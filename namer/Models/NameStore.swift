import Foundation
import SwiftUI

@MainActor
class NameStore: ObservableObject {
    @Published var favoriteNames: [GermanName] = []
    @Published private var personDetails: [String: PersonDetails] = [:]
    private let favoritesKey = "favoriteNames"
    private var recentlyRemovedFavorites: [GermanName] = []
    private var recentlyDeletedNames: [GermanName] = []
    private let maxUndoCount = 10
    private let detailsKey = "personDetails"
    
    init() {
        loadFavorites()
        loadDetails()
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([GermanName].self, from: data) {
            self.favoriteNames = decoded
            print("Loaded \(favoriteNames.count) favorites")
        }
    }
    
    private func loadDetails() {
        if let data = UserDefaults.standard.data(forKey: detailsKey),
           let decoded = try? JSONDecoder().decode([String: PersonDetails].self, from: data) {
            self.personDetails = decoded
        }
    }
    
    func toggleFavorite(_ name: GermanName) {
        print("Toggling favorite for: \(name.firstName) \(name.lastName)")
        if let index = favoriteNames.firstIndex(where: {
            $0.firstName == name.firstName &&
            $0.lastName == name.lastName &&
            $0.gender == name.gender &&
            $0.birthYear == name.birthYear
        }) {
            let removedName = favoriteNames.remove(at: index)
            recentlyRemovedFavorites.append(removedName)
            if recentlyRemovedFavorites.count > maxUndoCount {
                recentlyRemovedFavorites.removeFirst()
            }
            print("Removed from favorites. Count: \(favoriteNames.count)")
        } else {
            favoriteNames.append(name)
            print("Added to favorites. Count: \(favoriteNames.count)")
        }
        saveFavorites()
    }
    
    func undoRecentRemovals() {
        guard !recentlyRemovedFavorites.isEmpty else { return }
        
        withAnimation {
            favoriteNames.append(contentsOf: recentlyRemovedFavorites)
            recentlyRemovedFavorites.removeAll()
            saveFavorites()
        }
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteNames) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
            print("Saved \(favoriteNames.count) favorites")
        }
    }
    
    private func saveDetails() {
        if let encoded = try? JSONEncoder().encode(personDetails) {
            UserDefaults.standard.set(encoded, forKey: detailsKey)
        }
    }
    
    func getDetails(for name: GermanName) -> PersonDetails {
        let key = "\(name.firstName)_\(name.lastName)_\(name.birthYear)"
        return personDetails[key] ?? PersonDetails()
    }
    
    func saveDetails(_ details: PersonDetails, for name: GermanName) {
        let key = "\(name.firstName)_\(name.lastName)_\(name.birthYear)"
        personDetails[key] = details
        saveDetails()
    }
    
    func deleteGeneratedName(_ name: GermanName) {
        recentlyDeletedNames.append(name)
        if recentlyDeletedNames.count > maxUndoCount {
            recentlyDeletedNames.removeFirst()
        }
        if let index = favoriteNames.firstIndex(where: { $0.id == name.id }) {
            favoriteNames.remove(at: index)
            saveFavorites()
        }
    }
    
    func undoDeletedName() {
        guard !recentlyDeletedNames.isEmpty else { return }
        recentlyDeletedNames.removeLast()
    }
}
