import SwiftUI

struct CollectionsView: View {
    @EnvironmentObject private var nameStore: NameStore
    @State private var nameToUnfavorite: GermanName?
    @State private var showingUnfavoriteAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(nameStore.favoriteNames) { name in
                    HStack(spacing: 0) {
                        // Leading star button (filled, can unfavorite)
                        Button {
                            handleUnfavorite(name)
                        } label: {
                            Image(systemName: "star.fill")
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
                                
                                Button(role: .destructive) {
                                    handleUnfavorite(name)
                                } label: {
                                    Label("Entfernen", systemImage: "star.slash")
                                }
                            }
                        
                        Spacer()
                        
                        // Navigation chevron
                        NavigationLink(destination: NameDetailView(name: name)) {
                            EmptyView()
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Favoriten")
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if nameStore.favoriteNames.isEmpty {
                    ContentUnavailableView {
                        Label("Keine Favoriten", systemImage: "star")
                    } description: {
                        Text("Favorisierte Namen erscheinen hier")
                    }
                }
            }
        }
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
        .onShake {
            nameStore.undoRecentRemovals()
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
    CollectionsView()
        .environmentObject(NameStore())
}
