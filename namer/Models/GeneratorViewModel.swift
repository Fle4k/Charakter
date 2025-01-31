//
//  GeneratorViewModel.swift
//  Namer
//
//  Created by Shahin on 31.01.25.
//


import SwiftUI

class GeneratorViewModel: ObservableObject {
    @Published var generatedNamesList: GeneratedNamesList?
    @Published var nameHistory: [GermanName] = []
    let maxHistorySize = 300
    
    func addNamesToHistory(_ names: [GermanName]) {
        // Add new names at the beginning
        nameHistory.insert(contentsOf: names, at: 0)
        
        // Trim to keep only the last 300 names
        if nameHistory.count > maxHistorySize {
            nameHistory = Array(nameHistory.prefix(maxHistorySize))
        }
        
        generatedNamesList = GeneratedNamesList(names: names)
    }
}

struct GeneratedNamesList: Identifiable {
    let id = UUID()
    let names: [GermanName]
}