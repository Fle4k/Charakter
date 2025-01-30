import SwiftUI

struct GeneratedNamesListView: View {
    let names: [GermanName]
    @Binding var sheetDetent: PresentationDetent
    @EnvironmentObject private var nameStore: NameStore
    @State private var nameToUnfavorite: GermanName?
    @State private var showingUnfavoriteAlert = false
    
    var body: some View {
        List {
            ForEach(names) { name in
                HStack(spacing: 0) {
                    // Leading star button
                    Button {
                        handleUnfavorite(name)
                    } label: {
                        Image(systemName: nameStore.favoriteNames.contains(where: { $0.id == name.id }) ? "star.fill" : "star")
                            .foregroundStyle(.black)
                            .contentTransition(.symbolEffect(.replace))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 32)
                    
                    // Name with context menu
                    Text("\(name.firstName) \(name.lastName)")
                        .foregroundStyle(.black)
                        .padding(.leading, 8)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = "\(name.firstName) \(name.lastName)"
                            }) {
                                Label("Kopieren", systemImage: "doc.on.doc")
                            }
                        }
                    
                    Spacer()
                    
                    // Navigation chevron (only when favorited)
                    if nameStore.favoriteNames.contains(where: { $0.id == name.id }) {
                        NavigationLink(destination: NameDetailView(name: name)) {
                            EmptyView()
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Historie")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "Name entfernen?",
            isPresented: $showingUnfavoriteAlert,
            presenting: nameToUnfavorite
        ) { name in
            Button("Abbrechen", role: .cancel) {}
            Button("Entfernen", role: .destructive) {
                withAnimation {
                    nameStore.toggleFavorite(name)
                }
            }
        } message: { name in
            Text("Möchtest du '\(name.firstName) \(name.lastName)' wirklich aus deinen Favoriten entfernen? Alle gespeicherten Informationen gehen dabei verloren.")
        }
    }
    
    private func handleUnfavorite(_ name: GermanName) {
        if nameStore.favoriteNames.contains(where: { $0.id == name.id }) {
            print("Unfavoriting \(name.firstName)")
            // Only check for data if we're unfavoriting
            if nameStore.hasAdditionalData(name) {
                print("Has additional data, showing alert")
                nameToUnfavorite = name
                showingUnfavoriteAlert = true
            } else {
                print("No additional data, removing directly")
                withAnimation {
                    nameStore.toggleFavorite(name)
                }
            }
        } else {
            print("Favoriting \(name.firstName)")
            // If we're favoriting, just do it
            withAnimation {
                nameStore.toggleFavorite(name)
            }
        }
    }
}

#Preview {
    NavigationView {
        GeneratedNamesListView(
            names: [
                GermanName(firstName: "Max", lastName: "Mustermann", gender: .male, birthYear: 1990),
                GermanName(firstName: "Erika", lastName: "Musterfrau", gender: .female, birthYear: 1992)
            ],
            sheetDetent: .constant(.height(40))
        )
        .environmentObject(NameStore())
    }
}
