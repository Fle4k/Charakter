import SwiftUI

struct CollectionsView: View {
    @EnvironmentObject var nameStore: NameStore
    
    var groupedFavorites: [String: [GermanName]] {
        Dictionary(grouping: nameStore.favoriteNames) { $0.lastName.prefix(1).uppercased() }
    }
    
    var body: some View {
        NavigationView {
            List {
                if nameStore.favoriteNames.isEmpty {
                    Text("Keine Favoriten")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(groupedFavorites.keys.sorted(), id: \.self) { key in
                        Section(header: Text(key)) {
                            ForEach(groupedFavorites[key] ?? []) { name in
                                FavoriteNameRow(name: name)
                            }
                            .transition(.opacity)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Favoriten")
            .animation(.easeOut, value: nameStore.favoriteNames)
        }
        .onShake {
            nameStore.undoRecentRemovals()
        }
    }
}

struct FavoriteNameRow: View {
    @EnvironmentObject var nameStore: NameStore
    let name: GermanName
    
    var body: some View {
        NavigationLink(destination: NameDetailView(name: name)) {
            Text("\(name.firstName) \(name.lastName)")
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = "\(name.firstName) \(name.lastName)"
                    }) {
                        Label("Kopieren", systemImage: "doc.on.doc")
                    }
                    
                    Button(action: {
                        withAnimation {
                            nameStore.toggleFavorite(name)
                        }
                    }) {
                        Label("Von Favoriten entfernen", systemImage: "star.slash")
                    }
                }
        }
    }
}

#Preview {
    CollectionsView()
        .environmentObject(NameStore())
}
