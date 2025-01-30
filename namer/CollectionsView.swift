import SwiftUI

struct CollectionsView: View {
    @EnvironmentObject private var nameStore: NameStore
    @State private var nameToUnfavorite: GermanName?
    @State private var showingUnfavoriteAlert = false
    @State private var showingDeleteAlert = false
    @State private var selectedNamesHaveData = false
    @State private var isSelectionMode = false
    @State private var selectedNames: Set<String> = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(nameStore.favoriteNames) { name in
                    HStack(spacing: 0) {
                        // Leading selection circle or star
                        Button {
                            if isSelectionMode {
                                toggleSelection(name)
                            } else {
                                handleUnfavorite(name)
                            }
                        } label: {
                            if isSelectionMode {
                                Image(systemName: selectedNames.contains(name.id) ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(.black)
                                    .contentTransition(.symbolEffect(.replace))
                            } else {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.black)
                                    .contentTransition(.symbolEffect(.replace))
                            }
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
                                
                                if !isSelectionMode {
                                    Button(role: .destructive) {
                                        handleUnfavorite(name)
                                    } label: {
                                        Label("Entfernen", systemImage: "star.slash")
                                    }
                                }
                            }
                        
                        Spacer()
                        
                        // Navigation chevron (only when not in selection mode)
                        if !isSelectionMode {
                            NavigationLink(destination: NameDetailView(name: name)) {
                                EmptyView()
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Favoriten")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if nameStore.favoriteNames.isEmpty {
                        EmptyView()
                    } else if isSelectionMode {
                        Button(role: .destructive) {
                            deleteSelected()
                        } label: {
                            Text("Löschen (\(selectedNames.count))")
                                .foregroundStyle(.red)
                        }
                        .disabled(selectedNames.isEmpty)
                    } else {
                        Button {
                            withAnimation {
                                isSelectionMode.toggle()
                                selectedNames.removeAll()
                            }
                        } label: {
                            Text("Auswählen")
                        }
                    }
                }
                
                if isSelectionMode {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Abbrechen") {
                            withAnimation {
                                isSelectionMode = false
                                selectedNames.removeAll()
                            }
                        }
                    }
                }
            }
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
            "Namen entfernen?",
            isPresented: $showingDeleteAlert
        ) {
            Button("Abbrechen", role: .cancel) {}
            Button("Entfernen", role: .destructive) {
                // Delete all selected names
                for name in nameStore.favoriteNames where selectedNames.contains(name.id) {
                    nameStore.toggleFavorite(name)
                }
                isSelectionMode = false
                selectedNames.removeAll()
            }
        } message: {
            if selectedNamesHaveData {
                Text("Möchtest du \(selectedNames.count) Namen wirklich aus deinen Favoriten entfernen? Bei einigen Namen gehen dabei gespeicherte Informationen verloren.")
            } else {
                Text("Möchtest du \(selectedNames.count) Namen wirklich aus deinen Favoriten entfernen?")
            }
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
    
    private func toggleSelection(_ name: GermanName) {
        if selectedNames.contains(name.id) {
            selectedNames.remove(name.id)
        } else {
            selectedNames.insert(name.id)
        }
    }
    
    private func deleteSelected() {
        // Check if any selected names have data
        let namesWithData = nameStore.favoriteNames.filter { name in
            selectedNames.contains(name.id) && nameStore.hasAdditionalData(name)
        }
        
        selectedNamesHaveData = !namesWithData.isEmpty
        showingDeleteAlert = true
    }
}

#Preview {
    CollectionsView()
        .environmentObject(NameStore())
}
