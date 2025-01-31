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
                                    .foregroundStyle(Color.dynamicText)
                                    .contentTransition(.symbolEffect(.replace))
                            } else {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(Color.dynamicText)
                                    .contentTransition(.symbolEffect(.replace))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 32)
                        
                        // Name with context menu
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(name.firstName) \(name.lastName)")
                                .foregroundStyle(Color.dynamicText)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            let details = nameStore.getDetails(for: name)
                            if !details.hashtag.isEmpty {
                                Text("#\(details.hashtag)")
                                    .font(.caption)
                                    .foregroundStyle(Color.dynamicText.opacity(0.6))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        }
                        .padding(.leading, 8)
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
                                        .foregroundStyle(Color.dynamicText)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        // Navigation chevron (only when not in selection mode)
                        if !isSelectionMode {
                            NavigationLink(destination: NameDetailView(name: name)) {
                                EmptyView()
                            }
                            .tint(Color.dynamicText)
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
                                .foregroundStyle(Color.dynamicText)
                        }
                        .disabled(selectedNames.isEmpty)
                    } else {
                        Menu {
                            Button {
                                withAnimation {
                                    isSelectionMode.toggle()
                                    selectedNames.removeAll()
                                }
                            } label: {
                                Label("Auswählen", systemImage: "checkmark.circle")
                            }
                            
                            Button(role: .destructive) {
                                selectedNames = Set(nameStore.favoriteNames.map { $0.id })
                                selectedNamesHaveData = nameStore.favoriteNames.contains { nameStore.hasAdditionalData($0) }
                                showingDeleteAlert = true
                            } label: {
                                Label("Alle löschen", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color.dynamicText)
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
                            .foregroundStyle(Color.dynamicText)
                    } description: {
                        Text("Favorisierte Namen erscheinen hier")
                            .foregroundStyle(Color.dynamicText.opacity(0.6))
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
                    .foregroundStyle(Color.dynamicText)
            }
        }
        .tint(Color.dynamicText)
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
