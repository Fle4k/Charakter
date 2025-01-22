import SwiftUI

struct GeneratedNamesListView: View {
    let names: [PersonName]
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var nameStore: NameStore
    
    var sortedNames: [PersonName] {
        names.sorted { $0.lastName < $1.lastName }
    }
    
    var body: some View {
        List {
            ForEach(sortedNames) { name in
                HStack {
                    Text("\(name.firstName) \(name.lastName)")
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = "\(name.firstName) \(name.lastName)"
                            }) {
                                Label("Kopieren", systemImage: "doc.on.doc")
                            }
                        }
                    Spacer()
                    Button {
                        nameStore.toggleFavorite(name)
                    } label: {
                        Image(systemName: nameStore.favoriteNames.contains(where: { $0.id == name.id }) ? "star.fill" : "star")
                            .foregroundColor(nameStore.favoriteNames.contains(where: { $0.id == name.id }) ? .blue : .gray)
                    }
                }
            }
        }
        .navigationTitle("Neue Namen")
        .navigationBarItems(trailing: Button("Fertig", action: dismiss.callAsFunction))
    }
} 
