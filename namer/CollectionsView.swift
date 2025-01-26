import SwiftUI
import UniformTypeIdentifiers

// First, create a type for dragging GermanName
extension UTType {
    static let GermanName = UTType(exportedAs: "com.yourapp.GermanName")
}

struct CollectionsView: View {
    @StateObject private var nameStore = NameStore()
    @State private var showingNewCollectionSheet = false
    
    var groupedFavorites: [String: [GermanName]] {
        Dictionary(grouping: nameStore.favoriteNames) { $0.lastName.prefix(1).uppercased() }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Favoriten") {
                    if nameStore.favoriteNames.isEmpty {
                        Text("Keine Favoriten")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(groupedFavorites.keys.sorted(), id: \.self) { key in
                            Section(header: Text(key)) {
                                ForEach(groupedFavorites[key] ?? []) { name in
                                    FavoriteNameRow(name: name)
                                }
                            }
                        }
                    }
                }
                
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
            }
            .navigationTitle("Sammlungen")
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
    let name: GermanName
    
    var body: some View {
        HStack {
            Text("\(name.firstName) \(name.lastName)")
                .draggable(name)
        }
    }
}

#Preview {
    CollectionsView()
}
