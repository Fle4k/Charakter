import Foundation

@MainActor
class NameStore: ObservableObject {
    @Published private(set) var favoriteNames: [PersonName] = []
    private let saveKey = "FavoriteNames"
    
    init() {
        loadFavorites()
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([PersonName].self, from: data) {
            favoriteNames = decoded
        }
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteNames) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func addFavorite(_ name: PersonName) {
        if !favoriteNames.contains(where: { $0.id == name.id }) {
            favoriteNames.append(name)
            saveFavorites()
        }
    }
    
    func removeFavorite(_ name: PersonName) {
        if let index = favoriteNames.firstIndex(where: { $0.id == name.id }) {
            favoriteNames.remove(at: index)
            saveFavorites()
        }
    }
    
    func toggleFavorite(_ name: PersonName) {
        if favoriteNames.contains(where: { $0.id == name.id }) {
            removeFavorite(name)
        } else {
            addFavorite(name)
        }
    }
} 
