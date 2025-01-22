import SwiftUI

struct CollectionsView: View {
    @EnvironmentObject private var nameStore: NameStore
    
    var body: some View {
        NavigationView {
            Group {
                if nameStore.favoriteNames.isEmpty {
                    EmptyStateView()
                } else {
                    FavoritesList()
                        .environmentObject(nameStore)
                }
            }
            .animation(.default, value: nameStore.favoriteNames.isEmpty)
        }
    }
}

// Empty state view
private struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hier landen deine Favoriten")
                .font(.headline)
            Text("Generiere neue Namen und markiere sie als Favoriten")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

// Favorites list view
private struct FavoritesList: View {
    @EnvironmentObject private var nameStore: NameStore
    
    var body: some View {
        List {
            ForEach(groupedNames.keys.sorted(), id: \.self) { letter in
                Section(header: Text(letter)) {
                    ForEach(groupedNames[letter] ?? [], id: \.id) { name in
                        FavoriteNameRow(name: name)
                    }
                }
            }
        }
        .animation(.easeOut(duration: 0.3), value: nameStore.favoriteNames)
        .navigationTitle("Gespeicherte Namen")
        .onShake {
            nameStore.undoLastRemoval()
        }
    }
    
    private var groupedNames: [String: [PersonName]] {
        Dictionary(grouping: nameStore.favoriteNames) { name in
            String(name.lastName.prefix(1))
        }
    }
}

// Individual name row
private struct FavoriteNameRow: View {
    @EnvironmentObject private var nameStore: NameStore
    let name: PersonName
    
    var body: some View {
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
                withAnimation {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    
                    nameStore.toggleFavorite(name)
                }
            } label: {
                Image(systemName: "star.fill")
                    .foregroundColor(.blue)
            }
        }
    }
} 
