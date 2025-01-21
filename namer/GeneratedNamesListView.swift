import SwiftUI

struct GeneratedNamesListView: View {
    let names: [PersonName]
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var nameStore: NameStore
    
    var body: some View {
        List {
            ForEach(groupedNames.keys.sorted(), id: \.self) { letter in
                Section(header: Text(letter)) {
                    ForEach(groupedNames[letter] ?? []) { name in
                        HStack {
                            Text("\(name.firstName) \(name.lastName)")
                            Spacer()
                            if nameStore.favoriteNames.contains(where: { $0.id == name.id }) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            if nameStore.favoriteNames.contains(where: { $0.id == name.id }) {
                                Button(role: .destructive) {
                                    nameStore.toggleFavorite(name)
                                } label: {
                                    Label("Entfernen", systemImage: "star.slash")
                                }
                            } else {
                                Button {
                                    nameStore.toggleFavorite(name)
                                } label: {
                                    Label("Favorit", systemImage: "star")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Neue Namen")
        .navigationBarItems(trailing: Button("Fertig", action: dismiss.callAsFunction))
    }
    
    private var groupedNames: [String: [PersonName]] {
        Dictionary(grouping: names) { name in
            String(name.lastName.prefix(1))
        }
    }
} 