import Foundation
import SwiftUI

@MainActor
class NameStore: ObservableObject {
    @Published var favoriteNames: [GermanName] = []
    @Published var collections: [NameCollection] = []
    
    private let favoritesKey = "favoriteNames"
    private let collectionsKey = "collections"
    
    init() {
        loadCollections()
        loadFavorites()
    }
    
    private func loadCollections() {
        if let data = UserDefaults.standard.data(forKey: collectionsKey),
           let decoded = try? JSONDecoder().decode([NameCollection].self, from: data) {
            self.collections = decoded
            print("Loaded \(collections.count) collections")
        }
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([GermanName].self, from: data) {
            self.favoriteNames = decoded
            print("Loaded \(favoriteNames.count) favorites")
        }
    }
    
    func addCollection(_ collection: NameCollection) {
        collections.append(collection)
        saveCollections()
    }
    
    func toggleFavorite(_ name: GermanName) {
        print("Toggling favorite for: \(name.firstName) \(name.lastName)")
        if let index = favoriteNames.firstIndex(where: {
            $0.firstName == name.firstName &&
            $0.lastName == name.lastName &&
            $0.gender == name.gender &&
            $0.birthYear == name.birthYear
        }) {
            favoriteNames.remove(at: index)
            print("Removed from favorites. Count: \(favoriteNames.count)")
        } else {
            favoriteNames.append(name)
            print("Added to favorites. Count: \(favoriteNames.count)")
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
        if let encoded = try? JSONEncoder().encode(collections) {
            UserDefaults.standard.set(encoded, forKey: collectionsKey)
        }
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteNames) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
            print("Saved \(favoriteNames.count) favorites")
        }
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
