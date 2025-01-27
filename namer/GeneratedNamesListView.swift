import SwiftUI

struct GeneratedNamesListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var nameStore: NameStore
    let names: [GermanName]
    
    func isNameInFavorites(_ name: GermanName) -> Bool {
        nameStore.favoriteNames.contains(where: {
            $0.firstName == name.firstName &&
            $0.lastName == name.lastName &&
            $0.gender == name.gender &&
            $0.birthYear == name.birthYear
        })
    }
    
    var body: some View {
        List(names) { name in
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
                    Image(systemName: isNameInFavorites(name) ? "star.fill" : "star")
                        .foregroundStyle(.black)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Generierte Namen")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Fertig") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        GeneratedNamesListView(names: [
            GermanName(firstName: "Max", lastName: "Mustermann", gender: .male, birthYear: 1990),
            GermanName(firstName: "Erika", lastName: "Musterfrau", gender: .female, birthYear: 1992)
        ])
        .environmentObject(NameStore())
    }
}
