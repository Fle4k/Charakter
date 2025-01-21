import Foundation

class NameStore: ObservableObject {
    @Published var favoriteNames: [PersonName] = []
    
    func toggleFavorite(_ name: PersonName) {
        if let index = favoriteNames.firstIndex(where: { $0.id == name.id }) {
            favoriteNames.remove(at: index)
        } else {
            var newName = name
            newName.isFavorite = true
            favoriteNames.append(newName)
        }
    }
}