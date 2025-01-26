import Foundation
import SwiftUI
import UniformTypeIdentifiers

public enum AgeGroup: CaseIterable {
    static let diverseNames = ["Alex", "Robin", "Chris", "Sam", "Charlie", "Max", "Taylor", "Jamie", "Jordan", "Casey", "Jules", "Sascha", "Kim", "Pat", "Rene", "Nico", "Stevie", "Sky", "Elliot", "Marian", "Andrea", "Jan", "Noa", "Toni", "Jo", "Francis", "Morgan", "Angel", "Alexis", "Dominique", "Luca", "Eden", "Ari", "Noel", "Dakota", "Remy", "Sage", "Quinn", "Emery", "Rowan", "Rio", "Cameron", "Avery", "Finley", "Harley", "Jesse", "Logan", "Shay", "Evelyn", "Addison"]
    
    case child
    case teenager
    case youngAdult
    case adult
    case middleAge
    case senior
    case elderly
    
    static func getAgeGroup(birthYear: Int) -> AgeGroup {
        let currentYear = Calendar.current.component(.year, from: Date())
        let age = currentYear - birthYear
        
        switch age {
        case 0...12: return .child
        case 13...19: return .teenager
        case 20...30: return .youngAdult
        case 31...40: return .adult
        case 41...60: return .middleAge
        case 61...80: return .senior
        default: return .elderly
        }
    }
    
    var firstNames: [GermanName.Gender: [String]] {
        switch self {
        case .child:
            return [
                GermanName.Gender.female: ["Leonie", "Amelie", "Marie", "Hannah", "Lina", "Emilia", "Sophia", "Clara", "Mia", "Ella", "Lilly", "Luisa", "Nele", "Charlotte", "Anna", "Emma", "Leni", "Elisa", "Emily", "Johanna", "Greta", "Mathilda", "Mara", "Zoe", "Antonia", "Nora", "Isabella", "Victoria", "Thea", "Carla", "Mila", "Helena", "Stella", "Paula", "Frieda", "Melina", "Amalia", "Florentine", "Rosalie", "Anni", "Eva", "Josephine", "Jette", "Valentina", "Lara", "Ida", "Merle", "Sophia-Marie", "Annika", "Tilda"],
                GermanName.Gender.male: ["Ben", "Lukas", "Jonas", "Finn", "Elias", "Noah", "Leon", "Paul", "Maximilian", "Tim", "Luca", "Henry", "Felix", "Moritz", "Luis", "Julian", "Tom", "David", "Matteo", "Emil", "Linus", "Jakob", "Simon", "Mats", "Jannik", "Philipp", "Samuel", "Erik", "Oskar", "Levi", "Alexander", "Niklas", "Julius", "Max", "Fabian", "Tobias", "Jonathan", "Lennard", "Mika", "Sebastian", "Theo", "Lennox", "Vincent", "Johannes", "Jan", "Florian", "Michael", "Emanuel", "Nico", "Levin"],
                GermanName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .teenager:
            return [
                GermanName.Gender.female: ["Anna", "Laura", "Julia", "Marie", "Leonie", "Sophia", "Lena", "Hannah", "Lisa", "Sarah", "Mia", "Amelie", "Lara", "Johanna", "Emma", "Clara", "Emily", "Nele", "Paula", "Maja", "Charlotte", "Isabella", "Katharina", "Melina", "Greta", "Alina", "Luisa", "Fiona", "Elisa", "Lilly", "Theresa", "Jana", "Selina", "Franziska", "Julia-Sophie", "Carina", "Ella", "Helena", "Annika", "Sophie", "Josephine", "Nina", "Valentina", "Nora", "Frieda", "Leni", "Marlene", "Antonia", "Isabel", "Carolin"],
                GermanName.Gender.male: ["Tim", "Maximilian", "Paul", "Ben", "Jonas", "Felix", "Lukas", "Leon", "Elias", "Noah", "Mats", "Henry", "Finn", "Luca", "David", "Julian", "Tom", "Luis", "Linus", "Matteo", "Jonathan", "Simon", "Nico", "Max", "Samuel", "Philipp", "Erik", "Jakob", "Emil", "Jan", "Moritz", "Theo", "Vincent", "Oskar", "Mika", "Lennart", "Alexander", "Sebastian", "Adrian", "Julius", "Niklas", "Florian", "Rafael", "Levi", "Christoph", "Lenny", "Frederik", "Johannes", "Fabian", "Patrick"],
                GermanName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .youngAdult:
            return [
                GermanName.Gender.female: ["Lisa", "Katharina", "Michelle", "Sarah", "Anna", "Laura", "Julia", "Sabrina", "Vanessa", "Leonie", "Nadine", "Melanie", "Christina", "Nicole", "Sandra", "Lena", "Hannah", "Sophie", "Jennifer", "Theresa", "Marie", "Franziska", "Tanja", "Rebecca", "Stefanie", "Carina", "Jessica", "Miriam", "Elena", "Sophia", "Claudia", "Selina", "Jana", "Marlene", "Alina", "Patricia", "Fabienne", "Annika", "Antonia", "Johanna", "Carolin", "Pia", "Janine", "Romy", "Kathrin", "Celina", "Isabell", "Alicia", "Larissa", "Linda"],
                GermanName.Gender.male: ["Kevin", "Tobias", "Christian", "Daniel", "Michael", "Maximilian", "Lukas", "Julian", "Florian", "Sebastian", "Felix", "Marcel", "Patrick", "Nico", "Jonas", "Paul", "Leon", "Markus", "Philipp", "Andreas", "Jan", "Simon", "David", "Stefan", "Matthias", "Alexander", "Tim", "Dominik", "Fabian", "Sascha", "Thomas", "Benjamin", "Elias", "Jannik", "Samuel", "Jonas", "Marco", "Christopher", "Erik", "Matteo", "Marc", "Niklas", "Julius", "Adrian", "Levi", "Benedikt", "Lennart", "Robin", "Rafael", "Aaron"],
                GermanName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .adult:
            return [
                GermanName.Gender.female: ["Sandra", "Nadine", "Melanie", "Christina", "Nicole", "Julia", "Sarah", "Stefanie", "Anna", "Katharina", "Vanessa", "Daniela", "Jennifer", "Sabrina", "Jessica", "Laura", "Lisa", "Carina", "Miriam", "Sonja", "Franziska", "Claudia", "Bianca", "Verena", "Martina", "Tanja", "Nina", "Alexandra", "Maria", "Michaela", "Monika", "Petra", "Susanne", "Andrea", "Manuela", "Kerstin", "Silke", "Jana", "Leonie", "Eva", "Anja", "Carolin", "Katrin", "Michelle", "Christine", "Elisabeth", "Tamara", "Jacqueline", "Theresa", "Melina"],
                GermanName.Gender.male: ["Daniel", "Michael", "Stefan", "Thomas", "Christian", "Tobias", "Andreas", "Patrick", "Jan", "Alexander", "Sebastian", "Florian", "Kevin", "Markus", "Lukas", "Benjamin", "Julian", "Dominik", "Simon", "Philipp", "Nico", "Jonas", "Matthias", "Marc", "Felix", "Marcel", "Maximilian", "David", "Stephan", "Christopher", "Oliver", "Fabian", "Kai", "Rene", "Robin", "Jens", "Tim", "Benedikt", "Leon", "Matteo", "Elias", "Moritz", "Vincent", "Kilian", "Jannik", "Samuel", "Aaron", "Adrian", "Johannes", "Hannes"],
                GermanName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .middleAge:
            return [
                GermanName.Gender.female: ["Andrea", "Petra", "Claudia", "Susanne", "Monika", "Kerstin", "Birgit", "Sandra", "Nadine", "Melanie", "Nicole", "Christine", "Barbara", "Ulrike", "Heike", "Manuela", "Martina", "Sabrina", "Sonja", "Daniela", "Silke", "Anja", "Stephanie", "Gabriele", "Cornelia", "Brigitte", "Jutta", "Elke", "Angelika", "Sabine", "Carina", "Christina", "Marion", "Katharina", "Tanja", "Jennifer", "Annette", "Jana", "Renate", "Katrin", "Lisa", "Jessica", "Ute", "Anke", "Bettina", "Carola", "Michaela", "Beate", "Elisabeth", "Franziska"],
                GermanName.Gender.male: ["Thomas", "Frank", "Andreas", "Wolfgang", "Michael", "Stefan", "Peter", "Markus", "Klaus", "Manfred", "Rolf", "Norbert", "Hans", "Jürgen", "Dieter", "Joachim", "Reinhard", "Walter", "Karl", "Günter", "Horst", "Uwe", "Rainer", "Werner", "Helmut", "Herbert", "Bernd", "Detlef", "Alfred", "Volker", "Friedrich", "Dirk", "Wilhelm", "Siegfried", "Holger", "Carsten", "Torsten", "Ernst", "Roland", "Sven", "Hartmut", "Gottfried", "Adolf", "Berthold", "Otto", "Hubert", "Heinrich", "Ludwig", "Achim", "Axel"],
                GermanName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .senior:
            return [
                GermanName.Gender.female: ["Renate", "Ursula", "Gisela", "Elisabeth", "Ingrid", "Helga", "Marianne", "Gerda", "Hildegard", "Anneliese", "Karin", "Christa", "Erika", "Margarete", "Barbara", "Brigitte", "Hannelore", "Ilse", "Lore", "Waltraud", "Ruth", "Anna", "Josefine", "Bärbel", "Monika", "Margot", "Irmgard", "Sigrid", "Edeltraud", "Maria", "Käthe", "Edith", "Ingeborg", "Ellen", "Gabriele", "Beate", "Ute", "Petra", "Roswitha", "Angela", "Cornelia", "Astrid", "Elfriede", "Claudia", "Regina", "Silvia", "Angelika", "Antje", "Lieselotte", "Doris"],
                GermanName.Gender.male: ["Hans", "Heinz", "Wolfgang", "Karl", "Wilhelm", "Walter", "Franz", "Friedrich", "Werner", "Horst", "Herbert", "Günther", "Manfred", "Gustav", "Jürgen", "Rudolf", "Helmut", "Erwin", "Siegfried", "Otto", "Reinhard", "Bernd", "Peter", "Paul", "Rainer", "Dieter", "Joachim", "Klaus", "Gerhard", "Ludwig", "Eberhard", "Edgar", "Adolf", "Arnold", "Gottfried", "Harald", "Georg", "Norbert", "Rolf", "Ferdinand", "Heinrich", "Kurt", "Willi", "Alfred", "Erich", "Anton", "Fritz", "Hermann", "Matthias", "Wilfried"],
                GermanName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .elderly:
            return [
                GermanName.Gender.female: ["Erna", "Margarete", "Elisabeth", "Hedwig", "Anna", "Maria", "Frieda", "Wilhelmine", "Auguste", "Luise", "Clara", "Mathilde", "Emma", "Rosa", "Helene", "Johanna", "Theresia", "Anneliese", "Agnes", "Berta", "Gertrud", "Martha", "Ottilie", "Charlotte", "Herta", "Ida", "Amalie", "Adele", "Leokadia", "Thekla", "Cäcilia", "Elsa", "Marianne", "Meta", "Bertha", "Lina", "Grete", "Margot", "Rosalie", "Friedrike", "Henriette", "Susanna", "Caroline", "Brunhilde", "Adelheid", "Josefine", "Annelore", "Alma", "Johanne", "Ottilia"],
                GermanName.Gender.male: ["Wilhelm", "Karl", "Friedrich", "Hans", "Otto", "Heinrich", "Paul", "Franz", "Rudolf", "Ernst", "Hermann", "Theodor", "Josef", "Walter", "Johann", "August", "Alfred", "Georg", "Gustav", "Adolf", "Ludwig", "Bernhard", "Richard", "Anton", "Oskar", "Peter", "Jakob", "Konrad", "Armin", "Siegfried", "Eugen", "Ewald", "Waldemar", "Hans-Joachim", "Willi", "Kurt", "Fritz", "Herbert", "Werner", "Erwin", "Bruno", "Eberhard", "Rainer", "Joachim", "Hartmut", "Manfred", "Jürgen", "Gerhard", "Holger", "Klaus"],
                GermanName.Gender.diverse: AgeGroup.diverseNames
            ]
        }
    }
}

public struct GermanName: Identifiable, Codable, Equatable, Hashable, Transferable {
    public enum Gender: String, Codable, CaseIterable {
        case female = "Frau"
        case male = "Mann"
        case diverse = "Divers"
    }
    
    public let id: UUID
    public let firstName: String
    public let lastName: String
    public let gender: Gender
    public let birthYear: Int
    public var isFavorite: Bool
    
    public init(id: UUID = UUID(), firstName: String, lastName: String, gender: Gender, birthYear: Int, isFavorite: Bool = false) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.birthYear = birthYear
        self.isFavorite = isFavorite
    }
    
    public static func == (lhs: GermanName, rhs: GermanName) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .germanName)
    }
    
    public static func generateNames(
        count: Int = 50,
        gender: Gender,
        birthYear: Int,
        useAlliteration: Bool = false,
        useDoubleName: Bool = false
    ) -> [GermanName] {
        let ageGroup = AgeGroup.getAgeGroup(birthYear: birthYear)
        var names: [GermanName] = []
        
        let firstNames = ageGroup.firstNames[gender] ?? []
        
        // Group and select one random last name per letter
        let lastNames = Dictionary(grouping: ["Müller", "Schmidt", "Schneider", "Fischer", "Weber", "Meyer", "Wagner", "Becker", "Schulz", "Hoffmann", "Schäfer", "Koch", "Bauer", "Richter", "Klein", "Wolf", "Schröder", "Neumann", "Schwarz", "Zimmermann", "Braun", "Krüger", "Hofmann", "Hartmann", "Lange", "Schmitt", "Peters", "Otto", "Jung", "Imhoff", "Quandt", "Ullrich", "Vogel", "Thiel", "Dietrich", "Conrad", "Albrecht", "Gruber", "Ebert"]) {
            $0.prefix(1).lowercased()
        }
        .mapValues { names in
            names.randomElement() ?? ""
        }
        .values
        .sorted()
        
        let availableLastNames = Array(lastNames)
        
        // Generate one name for each available last name
        for lastName in availableLastNames {
            var firstName = firstNames.randomElement() ?? ""
            
            if useAlliteration {
                // Get all first names that start with the same letter as the last name
                let matchingFirstNames = firstNames.filter {
                    $0.prefix(1).lowercased() == lastName.prefix(1).lowercased()
                }
                
                if matchingFirstNames.isEmpty {
                    continue
                }
                
                firstName = matchingFirstNames.randomElement() ?? ""
                
                if useDoubleName {
                    // Get a different matching first name for the second part
                    let secondFirstName = matchingFirstNames
                        .filter { $0 != firstName }
                        .randomElement() ?? matchingFirstNames.randomElement() ?? ""
                    
                    names.append(GermanName(
                        firstName: "\(firstName)-\(secondFirstName)",
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                } else {
                    names.append(GermanName(
                        firstName: firstName,
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                }
            } else {
                if useDoubleName {
                    let secondFirstName = firstNames.randomElement() ?? ""
                    names.append(GermanName(
                        firstName: "\(firstName)-\(secondFirstName)",
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                } else {
                    names.append(GermanName(
                        firstName: firstName,
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                }
            }
            
            // Stop if we've reached the requested count
            if names.count >= count {
                break
            }
        }
        
        return names.sorted { first, second in
            if first.lastName == second.lastName {
                return first.firstName < second.firstName
            }
            return first.lastName < second.lastName
        }
    }
}
