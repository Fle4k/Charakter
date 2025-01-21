import Foundation

// Define Gender as part of PersonName to avoid ambiguity
struct PersonName: Identifiable, Codable {
    enum Gender: String, Codable, CaseIterable {
        case female = "Frau"
        case male = "Mann"
        case diverse = "Divers"
    }
    
    let id: UUID
    let firstName: String
    let lastName: String
    let gender: Gender
    let birthYear: Int
    var isFavorite: Bool
    
    init(id: UUID = UUID(), firstName: String, lastName: String, gender: Gender, birthYear: Int, isFavorite: Bool = false) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.birthYear = birthYear
        self.isFavorite = isFavorite
    }
}

// Name generation functionality
extension PersonName {
    private static let sampleFirstNames: [Gender: [String]] = [
        .female: ["Andrea", "Anette", "Antje", "Carla", "Claire", "Dia", "Doro"],
        .male: ["Andreas", "Anton", "Boris", "Bodo", "Carl", "David", "Dennis"],
        .diverse: ["Alex", "Chris", "Dominique", "Eden", "Finn", "Gene", "Jordan"]
    ]
    
    private static let sampleLastNames = [
        "Albrecht", "Appel", "Auer", "Brecht", "Brechnau", "Brunner",
        "Christ", "Conrad", "Caspar", "Drexer", "Dahl"
    ]
    
    static func generateRandom(gender: Gender, birthYear: Int, useAlliteration: Bool = false, useDoubleName: Bool = false) -> PersonName {
        let firstNames = sampleFirstNames[gender] ?? []
        let firstName = firstNames.randomElement() ?? "Unknown"
        
        if useAlliteration {
            let firstLetter = firstName.prefix(1)
            let matchingLastNames = sampleLastNames.filter { $0.starts(with: firstLetter) }
            let lastName = matchingLastNames.randomElement() ?? sampleLastNames.randomElement() ?? "Unknown"
            return PersonName(firstName: firstName, lastName: lastName, gender: gender, birthYear: birthYear)
        }
        
        let lastName = sampleLastNames.randomElement() ?? "Unknown"
        return PersonName(firstName: firstName, lastName: lastName, gender: gender, birthYear: birthYear)
    }
} 
