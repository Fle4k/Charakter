import Foundation

@MainActor
class NameStore: ObservableObject {
    @Published private(set) var favoriteNames: [PersonName] = []
    private var lastRemovedName: PersonName?
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
        if let index = favoriteNames.firstIndex(where: { $0.id == name.id }) {
            lastRemovedName = favoriteNames[index]
            favoriteNames.remove(at: index)
            saveFavorites()
        } else {
            var nameToAdd = name
            nameToAdd.isFavorite = true
            favoriteNames.append(nameToAdd)
            saveFavorites()
        }
    }
    
    func undoLastRemoval() {
        if let name = lastRemovedName {
            favoriteNames.append(name)
            lastRemovedName = nil
            saveFavorites()
        }
    }
    
    // Add persistence
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                  in: .userDomainMask,
                                  appropriateFor: nil,
                                  create: false)
        .appendingPathComponent("favorites.data")
    }
    
    func load() {
        do {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else { return }
            favoriteNames = try JSONDecoder().decode([PersonName].self, from: data)
        } catch {
            print("Error loading favorites: \(error)")
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(favoriteNames)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        } catch {
            print("Error saving favorites: \(error)")
        }
    }
} 
