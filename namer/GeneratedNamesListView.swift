import SwiftUI

struct GeneratedNamesListView: View {
    let names: [GermanName]
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var nameStore: NameStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(names) { name in
                    HStack(spacing: 0) {
                        // Leading star button
                        Button {
                            withAnimation {
                                nameStore.toggleFavorite(name)
                            }
                        } label: {
                            Image(systemName: nameStore.favoriteNames.contains(where: { $0.id == name.id }) ? "star.fill" : "star")
                                .foregroundStyle(.black)
                                .contentTransition(.symbolEffect(.replace))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 32)  // Fixed width for star
                        
                        // Name with context menu
                        Text("\(name.firstName) \(name.lastName)")
                            .foregroundStyle(.black)
                            .padding(.leading, 8)  // Space between star and name
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fertig") {
                        dismiss()
                    }
                }
            }
        }
        .tint(.black)
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
