import Foundation
import SwiftUI

@MainActor
class NameStore: ObservableObject {
    @Published var favoriteNames: [GermanName] = []
    @Published var collections: [NameCollection] = []
    
    init() {
        loadCollections()
        loadFavorites()
    }
    
    private func loadCollections() {
        // Load collections from persistence
        // For now, just initialize with empty array if no saved data
        self.collections = []
    }
    
    private func loadFavorites() {
        // Load favorites from persistence
        // For now, just initialize with empty array if no saved data
        self.favoriteNames = []
    }
    
    func addCollection(_ collection: NameCollection) {
        collections.append(collection)
        saveCollections()
    }
    
    func toggleFavorite(_ name: GermanName) {
        if let index = favoriteNames.firstIndex(where: {
            $0.firstName == name.firstName &&
            $0.lastName == name.lastName &&
            $0.gender == name.gender &&
            $0.birthYear == name.birthYear
        }) {
            favoriteNames.remove(at: index)
        } else {
            favoriteNames.append(name)
        }
        saveFavorites()
    }
    
    func addNameToCollection(_ name: GermanName, to collectionId: UUID) {
        if let index = collections.firstIndex(where: { $0.id == collectionId }) {
            var collection = collections[index]
            if !collection.names.contains(where: { $0.id == name.id }) {
                collection.names.append(name)
                collections[index] = collection
                saveCollections()
            }
        }
    }
    
    func removeFavorite(_ name: GermanName) {
        if let index = favoriteNames.firstIndex(where: { $0.id == name.id }) {
            favoriteNames.remove(at: index)
            saveFavorites()
        }
    }
    
    private func saveCollections() {
        // Implement persistence logic here
    }
    
    private func saveFavorites() {
        // Implement persistence logic here
    }
    
    func deleteCollection(at offsets: IndexSet) {
        collections.remove(atOffsets: offsets)
        saveCollections()
    }
    
    func renameCollection(_ id: UUID, to newName: String) {
        if let index = collections.firstIndex(where: { $0.id == id }) {
            var updatedCollection = collections[index]
            updatedCollection.name = newName
            collections[index] = updatedCollection
            saveCollections()
        }
    }
}
