import SwiftUI

class GeneratorViewModel: ObservableObject {
    @Published var generatedNamesList: GeneratedNamesList?
    @Published var nameHistory: [GermanName] = []
    let maxHistorySize = 300
    private let historyKey = "nameHistory"  // Add this
    
    init() {
        loadHistory()  // Add this
    }
    
    func addNamesToHistory(_ names: [GermanName]) {
        // Add new names at the beginning
        nameHistory.insert(contentsOf: names, at: 0)
        
        // Trim to keep only the last 300 names
        if nameHistory.count > maxHistorySize {
            nameHistory = Array(nameHistory.prefix(maxHistorySize))
        }
        
        generatedNamesList = GeneratedNamesList(names: names)
        saveHistory()  // Add this
    }
    
    // Add these methods
    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(nameHistory) {
            UserDefaults.standard.set(encoded, forKey: historyKey)
        }
    }
    
    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: historyKey),
           let decoded = try? JSONDecoder().decode([GermanName].self, from: data) {
            nameHistory = decoded
        }
    }
}

struct GeneratedNamesList: Identifiable {
    let id = UUID()
    let names: [GermanName]
}
