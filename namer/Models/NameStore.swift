import Foundation
import SwiftUI

@MainActor
class NameStore: ObservableObject {
    @Published private(set) var favoriteNames: [GermanName] = []
    @Published private var personDetails: [String: PersonDetails] = [:]
    private let favoritesKey = "favoriteNames"
    private var recentlyRemovedNames: [GermanName] = []
    private var recentlyDeletedNames: [GermanName] = []
    private let maxUndoCount = 10
    private let detailsKey = "nameDetails_"
    private let imageDirectory = "StoredImages"
    
    // Add new properties for image handling
    private let imagePrefix = "nameImage_"
    private let imageRefsKey = "nameImageRefs"
    private let imageKey = "image_"
    
    init() {
        loadFavorites()
        loadDetails()
        createImageDirectoryIfNeeded()
    }
    
    private func createImageDirectoryIfNeeded() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imagesURL = url.appendingPathComponent(imageDirectory)
        
        if !FileManager.default.fileExists(atPath: imagesURL.path) {
            try? FileManager.default.createDirectory(at: imagesURL, withIntermediateDirectories: true)
        }
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([GermanName].self, from: data) {
            self.favoriteNames = decoded
            print("Loaded \(favoriteNames.count) favorites")
        }
    }
    
    private func loadDetails() {
        print("Loading details from UserDefaults")
        if let data = UserDefaults.standard.data(forKey: detailsKey),
           let decoded = try? JSONDecoder().decode([String: PersonDetails].self, from: data) {
            self.personDetails = decoded
            print("Loaded details: \(decoded)")
        } else {
            print("No details found in UserDefaults")
            // Initialize empty dictionary if nothing found
            self.personDetails = [:]
        }
    }
    
    func toggleFavorite(_ name: GermanName) {
        if let index = favoriteNames.firstIndex(where: { $0.id == name.id }) {
            recentlyRemovedNames.append(favoriteNames[index])
            favoriteNames.remove(at: index)
            // Delete associated data when removing from favorites
            deleteDetails(for: name)
            deleteImage(for: name)
        } else {
            favoriteNames.append(name)
        }
        saveFavorites()
    }
    
    func undoRecentRemovals() {
        guard !recentlyRemovedNames.isEmpty else { return }
        favoriteNames.append(contentsOf: recentlyRemovedNames)
        recentlyRemovedNames.removeAll()
        saveFavorites()
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteNames) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
            print("Saved \(favoriteNames.count) favorites")
        }
    }
    
    private func saveDetails() {
        print("Saving all details to UserDefaults")
        print("Current personDetails: \(personDetails)")
        if let encoded = try? JSONEncoder().encode(personDetails) {
            UserDefaults.standard.set(encoded, forKey: detailsKey)
            UserDefaults.standard.synchronize() // Force save
            print("Successfully saved to UserDefaults")
        }
    }
    
    private func makeKey(for name: GermanName) -> String {
        // Always use the UUID as the key
        return name.id
    }
    
    func getDetails(for name: GermanName) -> PersonDetails {
        let key = makeKey(for: name)
        print("Getting details for key: \(key)")
        let details = personDetails[key] ?? PersonDetails()
        print("Found details: \(details)")
        return details
    }
    
    func saveDetails(_ details: PersonDetails, for name: GermanName) {
        let key = makeKey(for: name)
        print("Saving details for key: \(key)")
        print("Details being saved: \(details)")
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
    
    // Save image for a name
    func saveImage(_ image: UIImage, for name: GermanName) {
        guard let data = image.jpegData(compressionQuality: 0.7) else { return }
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to get document directory")
            return
        }
        
        let imagesURL = url.appendingPathComponent(imageDirectory)
        let fileURL = imagesURL.appendingPathComponent("\(name.id).jpg")
        
        do {
            try data.write(to: fileURL)
            print("Image saved successfully for \(name.firstName)")
        } catch {
            print("Failed to save image: \(error.localizedDescription)")
        }
    }
    
    // Load image for a name
    func loadImage(for name: GermanName) -> UIImage? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let imagesURL = url.appendingPathComponent(imageDirectory)
        let fileURL = imagesURL.appendingPathComponent("\(name.id).jpg")
        
        if let data = try? Data(contentsOf: fileURL) {
            return UIImage(data: data)
        }
        
        return nil
    }
    
    // Delete image for a name
    func deleteImage(for name: GermanName) {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let imagesURL = url.appendingPathComponent(imageDirectory)
        let fileURL = imagesURL.appendingPathComponent("\(name.id).jpg")
        
        try? FileManager.default.removeItem(at: fileURL)
    }
    
    func hasAdditionalData(_ name: GermanName) -> Bool {
        let key = makeKey(for: name)
        print("Checking additional data for key: \(key)")
        print("All personDetails keys: \(personDetails.keys.joined(separator: ", "))")
        
        if let details = personDetails[key] {
            let hasData = !details.height.isEmpty ||
                         !details.hairColor.isEmpty ||
                         !details.eyeColor.isEmpty ||
                         !details.characteristics.isEmpty ||
                         !details.style.isEmpty ||
                         !details.type.isEmpty
            print("Found details for \(name.firstName): hasData=\(hasData)")
            print("Details content: height='\(details.height)', hair='\(details.hairColor)', eyes='\(details.eyeColor)', characteristics='\(details.characteristics)', style='\(details.style)', type='\(details.type)'")
            return hasData
        }
        print("No details found for key: \(key)")
        return false
    }
    
    private func deleteDetails(for name: GermanName) {
        let key = makeKey(for: name)
        print("Deleting details for key: \(key)")
        personDetails.removeValue(forKey: key)
        saveDetails()
    }
}
