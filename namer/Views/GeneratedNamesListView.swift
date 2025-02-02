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
                        handleFavoriteAction(for: name)
                    } label: {
                        Image(systemName: nameStore.favoriteNames.contains(where: { $0.id == name.id }) ? "star.fill" : "star")
                            .foregroundStyle(Color.dynamicText)
                            .contentTransition(.symbolEffect(.replace))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 32)
                    
                    // Name with context menu
                    Text("\(name.firstName) \(name.lastName)")
                        .foregroundStyle(Color.dynamicText)
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
                    
                    // Navigation chevron
                    if nameStore.favoriteNames.contains(where: { $0.id == name.id }) {
                        NavigationLink(destination: NameDetailView(name: name)) {
                            EmptyView()
                        }
                        .tint(Color.dynamicText)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("")  // Empty title for sheet
        .navigationBarTitleDisplayMode(.inline)
        .tint(Color.dynamicText)
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
    
    private func handleFavoriteAction(for name: GermanName) {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        
        if nameStore.favoriteNames.contains(where: { $0.id == name.id }) {
            handleUnfavorite(name)
        } else {
            withAnimation {
                generator.selectionChanged()  // Changed to selection feedback
                nameStore.toggleFavorite(name)
            }
        }
    }
    
    private func handleUnfavorite(_ name: GermanName) {
        if nameStore.hasAdditionalData(name) {
            nameToUnfavorite = name
            showingUnfavoriteAlert = true
        } else {
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
