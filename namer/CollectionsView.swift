import SwiftUI

struct CollectionsView: View {
    @EnvironmentObject var nameStore: NameStore
    @State private var showingNewCollectionSheet = false
    
    var groupedFavorites: [String: [GermanName]] {
        Dictionary(grouping: nameStore.favoriteNames) { $0.lastName.prefix(1).uppercased() }
    }
    
    var body: some View {
        NavigationView {
            List {
                
                Section("Sammlungen") {
                    if nameStore.collections.isEmpty {
                        Text("Keine Sammlungen")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(nameStore.collections) { collection in
                            NavigationLink(destination: CollectionDetailView(collection: collection)) {
                                Text(collection.name)
                            }
                        }
                    }
                }
                Section("Favoriten") {
                    if nameStore.favoriteNames.isEmpty {
                        Text("Keine Favoriten")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(groupedFavorites.keys.sorted(), id: \.self) { key in
                            Section(header: Text(key)) {
                                ForEach(groupedFavorites[key] ?? []) { name in
                                    FavoriteNameRow(name: name)
                                        .environmentObject(nameStore)
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                Button {
                    showingNewCollectionSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingNewCollectionSheet) {
                NewCollectionSheet()
                    .environmentObject(nameStore)
            }
        }
    }
}

struct FavoriteNameRow: View {
    @EnvironmentObject var nameStore: NameStore
    let name: GermanName
    
    var body: some View {
        HStack {
            Text("\(name.firstName) \(name.lastName)")
            
            Spacer()
            
            Menu {
                Button(action: {
                    UIPasteboard.general.string = "\(name.firstName) \(name.lastName)"
                }) {
                    Label("Kopieren", systemImage: "doc.on.doc")
                }
                
                Button(role: .destructive, action: {
                    nameStore.toggleFavorite(name)
                }) {
                    Label("Entfernen", systemImage: "star.slash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.gray)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                nameStore.toggleFavorite(name)
            } label: {
                Label("Entfernen", systemImage: "star.slash")
            }
            
            Button {
                UIPasteboard.general.string = "\(name.firstName) \(name.lastName)"
            } label: {
                Label("Kopieren", systemImage: "doc.on.doc")
            }
            .tint(.blue)
        }
    }
}

#Preview {
    CollectionsView()
        .environmentObject(NameStore())
}
