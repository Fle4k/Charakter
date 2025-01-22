import Foundation

// Move AgeGroup outside of PersonName
enum AgeGroup: CaseIterable {
    static let diverseNames = ["Alex", "Robin", "Chris", "Sam", "Charlie", "Max", "Taylor", "Jamie", "Jordan", "Casey", "Jules", "Sascha", "Kim", "Pat", "Rene", "Nico", "Stevie", "Sky", "Elliot", "Marian", "Andrea", "Jan", "Noa", "Toni", "Jo", "Francis", "Morgan", "Angel", "Alexis", "Dominique", "Luca", "Eden", "Ari", "Noel", "Dakota", "Remy", "Sage", "Quinn", "Emery", "Rowan", "Rio", "Cameron", "Avery", "Finley", "Harley", "Jesse", "Logan", "Shay", "Evelyn", "Addison"]
    
    case child
    case teenager
    case youngAdult
    case adult
    case middleAge
    case senior
    case elderly
    
    var firstNames: [PersonName.Gender: [String]] {
        switch self {
        case .child:
            return [
                PersonName.Gender.female: ["Leonie", "Amelie", "Marie", "Hannah", "Lina", "Emilia", "Sophia", "Clara", "Mia", "Ella", "Lilly", "Luisa", "Nele", "Charlotte", "Anna", "Emma", "Leni", "Elisa", "Emily", "Johanna", "Greta", "Mathilda", "Mara", "Zoe", "Antonia", "Nora", "Isabella", "Victoria", "Thea", "Carla", "Mila", "Helena", "Stella", "Paula", "Frieda", "Melina", "Amalia", "Florentine", "Rosalie", "Anni", "Eva", "Josephine", "Jette", "Valentina", "Lara", "Ida", "Merle", "Sophia-Marie", "Annika", "Tilda"],
                PersonName.Gender.male: ["Ben", "Lukas", "Jonas", "Finn", "Elias", "Noah", "Leon", "Paul", "Maximilian", "Tim", "Luca", "Henry", "Felix", "Moritz", "Luis", "Julian", "Tom", "David", "Matteo", "Emil", "Linus", "Jakob", "Simon", "Mats", "Jannik", "Philipp", "Samuel", "Erik", "Oskar", "Levi", "Alexander", "Niklas", "Julius", "Max", "Fabian", "Tobias", "Jonathan", "Lennard", "Mika", "Sebastian", "Theo", "Lennox", "Vincent", "Johannes", "Jan", "Florian", "Michael", "Emanuel", "Nico", "Levin"],
                PersonName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .teenager:
            return [
                PersonName.Gender.female: ["Anna", "Laura", "Julia", "Marie", "Leonie", "Sophia", "Lena", "Hannah", "Lisa", "Sarah", "Mia", "Amelie", "Lara", "Johanna", "Emma", "Clara", "Emily", "Nele", "Paula", "Maja", "Charlotte", "Isabella", "Katharina", "Melina", "Greta", "Alina", "Luisa", "Fiona", "Elisa", "Lilly", "Theresa", "Jana", "Selina", "Franziska", "Julia-Sophie", "Carina", "Ella", "Helena", "Annika", "Sophie", "Josephine", "Nina", "Valentina", "Nora", "Frieda", "Leni", "Marlene", "Antonia", "Isabel", "Carolin"],
                PersonName.Gender.male: ["Tim", "Maximilian", "Paul", "Ben", "Jonas", "Felix", "Lukas", "Leon", "Elias", "Noah", "Mats", "Henry", "Finn", "Luca", "David", "Julian", "Tom", "Luis", "Linus", "Matteo", "Jonathan", "Simon", "Nico", "Max", "Samuel", "Philipp", "Erik", "Jakob", "Emil", "Jan", "Moritz", "Theo", "Vincent", "Oskar", "Mika", "Lennart", "Alexander", "Sebastian", "Adrian", "Julius", "Niklas", "Florian", "Rafael", "Levi", "Christoph", "Lenny", "Frederik", "Johannes", "Fabian", "Patrick"],
                PersonName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .youngAdult:
            return [
                PersonName.Gender.female: ["Lisa", "Katharina", "Michelle", "Sarah", "Anna", "Laura", "Julia", "Sabrina", "Vanessa", "Leonie", "Nadine", "Melanie", "Christina", "Nicole", "Sandra", "Lena", "Hannah", "Sophie", "Jennifer", "Theresa", "Marie", "Franziska", "Tanja", "Rebecca", "Stefanie", "Carina", "Jessica", "Miriam", "Elena", "Sophia", "Claudia", "Selina", "Jana", "Marlene", "Alina", "Patricia", "Fabienne", "Annika", "Antonia", "Johanna", "Carolin", "Pia", "Janine", "Romy", "Kathrin", "Celina", "Isabell", "Alicia", "Larissa", "Linda"],
                PersonName.Gender.male: ["Kevin", "Tobias", "Christian", "Daniel", "Michael", "Maximilian", "Lukas", "Julian", "Florian", "Sebastian", "Felix", "Marcel", "Patrick", "Nico", "Jonas", "Paul", "Leon", "Markus", "Philipp", "Andreas", "Jan", "Simon", "David", "Stefan", "Matthias", "Alexander", "Tim", "Dominik", "Fabian", "Sascha", "Thomas", "Benjamin", "Elias", "Jannik", "Samuel", "Jonas", "Marco", "Christopher", "Erik", "Matteo", "Marc", "Niklas", "Julius", "Adrian", "Levi", "Benedikt", "Lennart", "Robin", "Rafael", "Aaron"],
                PersonName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .adult:
            return [
                PersonName.Gender.female: ["Sandra", "Nadine", "Melanie", "Christina", "Nicole", "Julia", "Sarah", "Stefanie", "Anna", "Katharina", "Vanessa", "Daniela", "Jennifer", "Sabrina", "Jessica", "Laura", "Lisa", "Carina", "Miriam", "Sonja", "Franziska", "Claudia", "Bianca", "Verena", "Martina", "Tanja", "Nina", "Alexandra", "Maria", "Michaela", "Monika", "Petra", "Susanne", "Andrea", "Manuela", "Kerstin", "Silke", "Jana", "Leonie", "Eva", "Anja", "Carolin", "Katrin", "Michelle", "Christine", "Elisabeth", "Tamara", "Jacqueline", "Theresa", "Melina"],
                PersonName.Gender.male: ["Daniel", "Michael", "Stefan", "Thomas", "Christian", "Tobias", "Andreas", "Patrick", "Jan", "Alexander", "Sebastian", "Florian", "Kevin", "Markus", "Lukas", "Benjamin", "Julian", "Dominik", "Simon", "Philipp", "Nico", "Jonas", "Matthias", "Marc", "Felix", "Marcel", "Maximilian", "David", "Stephan", "Christopher", "Oliver", "Fabian", "Kai", "Rene", "Robin", "Jens", "Tim", "Benedikt", "Leon", "Matteo", "Elias", "Moritz", "Vincent", "Kilian", "Jannik", "Samuel", "Aaron", "Adrian", "Johannes", "Hannes"],
                PersonName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .middleAge:
            return [
                PersonName.Gender.female: ["Andrea", "Petra", "Claudia", "Susanne", "Monika", "Kerstin", "Birgit", "Sandra", "Nadine", "Melanie", "Nicole", "Christine", "Barbara", "Ulrike", "Heike", "Manuela", "Martina", "Sabrina", "Sonja", "Daniela", "Silke", "Anja", "Stephanie", "Gabriele", "Cornelia", "Brigitte", "Jutta", "Elke", "Angelika", "Sabine", "Carina", "Christina", "Marion", "Katharina", "Tanja", "Jennifer", "Annette", "Jana", "Renate", "Katrin", "Lisa", "Jessica", "Ute", "Anke", "Bettina", "Carola", "Michaela", "Beate", "Elisabeth", "Franziska"],
                PersonName.Gender.male: ["Thomas", "Frank", "Andreas", "Wolfgang", "Michael", "Stefan", "Peter", "Markus", "Klaus", "Manfred", "Rolf", "Norbert", "Hans", "Jürgen", "Dieter", "Joachim", "Reinhard", "Walter", "Karl", "Günter", "Horst", "Uwe", "Rainer", "Werner", "Helmut", "Herbert", "Bernd", "Detlef", "Alfred", "Volker", "Friedrich", "Dirk", "Wilhelm", "Siegfried", "Holger", "Carsten", "Torsten", "Ernst", "Roland", "Sven", "Hartmut", "Gottfried", "Adolf", "Berthold", "Otto", "Hubert", "Heinrich", "Ludwig", "Achim", "Axel"],
                PersonName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .senior:
            return [
                PersonName.Gender.female: ["Renate", "Ursula", "Gisela", "Elisabeth", "Ingrid", "Helga", "Marianne", "Gerda", "Hildegard", "Anneliese", "Karin", "Christa", "Erika", "Margarete", "Barbara", "Brigitte", "Hannelore", "Ilse", "Lore", "Waltraud", "Ruth", "Anna", "Josefine", "Bärbel", "Monika", "Margot", "Irmgard", "Sigrid", "Edeltraud", "Maria", "Käthe", "Edith", "Ingeborg", "Ellen", "Gabriele", "Beate", "Ute", "Petra", "Roswitha", "Angela", "Cornelia", "Astrid", "Elfriede", "Claudia", "Regina", "Silvia", "Angelika", "Antje", "Lieselotte", "Doris"],
                PersonName.Gender.male: ["Hans", "Heinz", "Wolfgang", "Karl", "Wilhelm", "Walter", "Franz", "Friedrich", "Werner", "Horst", "Herbert", "Günther", "Manfred", "Gustav", "Jürgen", "Rudolf", "Helmut", "Erwin", "Siegfried", "Otto", "Reinhard", "Bernd", "Peter", "Paul", "Rainer", "Dieter", "Joachim", "Klaus", "Gerhard", "Ludwig", "Eberhard", "Edgar", "Adolf", "Arnold", "Gottfried", "Harald", "Georg", "Norbert", "Rolf", "Ferdinand", "Heinrich", "Kurt", "Willi", "Alfred", "Erich", "Anton", "Fritz", "Hermann", "Matthias", "Wilfried"],
                PersonName.Gender.diverse: AgeGroup.diverseNames
            ]
        case .elderly:
            return [
                PersonName.Gender.female: ["Erna", "Margarete", "Elisabeth", "Hedwig", "Anna", "Maria", "Frieda", "Wilhelmine", "Auguste", "Luise", "Clara", "Mathilde", "Emma", "Rosa", "Helene", "Johanna", "Theresia", "Anneliese", "Agnes", "Berta", "Gertrud", "Martha", "Ottilie", "Charlotte", "Herta", "Ida", "Amalie", "Adele", "Leokadia", "Thekla", "Cäcilia", "Elsa", "Marianne", "Meta", "Bertha", "Lina", "Grete", "Margot", "Rosalie", "Friedrike", "Henriette", "Susanna", "Caroline", "Brunhilde", "Adelheid", "Josefine", "Annelore", "Alma", "Johanne", "Ottilia"],
                PersonName.Gender.male: ["Wilhelm", "Karl", "Friedrich", "Hans", "Otto", "Heinrich", "Paul", "Franz", "Rudolf", "Ernst", "Hermann", "Theodor", "Josef", "Walter", "Johann", "August", "Alfred", "Georg", "Gustav", "Adolf", "Ludwig", "Bernhard", "Richard", "Anton", "Oskar", "Peter", "Jakob", "Konrad", "Armin", "Siegfried", "Eugen", "Ewald", "Waldemar", "Hans-Joachim", "Willi", "Kurt", "Fritz", "Herbert", "Werner", "Erwin", "Bruno", "Eberhard", "Rainer", "Joachim", "Hartmut", "Manfred", "Jürgen", "Gerhard", "Holger", "Klaus"],
                PersonName.Gender.diverse: AgeGroup.diverseNames
            ]
        }
    }
}

struct PersonName: Identifiable, Codable, Equatable {
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
    
    // Add Equatable conformance
    static func == (lhs: PersonName, rhs: PersonName) -> Bool {
        lhs.id == rhs.id
    }
}

// Name generation functionality
extension PersonName {
    private static let sampleLastNames = [
        "Zahn", "Zapf", "Zander", "Zeidler", "Zeh", "Zeise", "Zeller", "Zentgraf", "Zerbe", "Zettl", "Zick", "Ziegler", "Zimmer", "Zimmermann", "Zinke", "Zobel", "Zöller", "Zorn", "Zuber", "Zuck", "Zufall", "Zuleger", "Zumsande", "Zündorf", "Zurbriggen", "Zürcher", "Zwanziger", "Zwicker", "Zwilling", "Zwingmann", "Schmidt", "Schneider", "Fischer", "Weber", "Meyer", "Wagner", "Becker", "Schulz", "Hoffmann", "Schäfer", "Koch", "Bauer", "Richter", "Klein", "Wolf", "Schröder", "Neumann", "Schwarz", "Zimmermann", "Braun", "Krüger", "Hofmann", "Hartmann", "Lange", "Schmitt", "Werner", "Schmitz", "Krause", "Meier", "Lehmann", "Schmid", "Schulze", "Maier", "Köhler", "Herrmann", "König", "Walter", "Mayer", "Huber", "Kaiser", "Fuchs", "Peters", "Lang", "Scholz", "Möller", "Weiß", "Jung", "Hahn", "Schubert", "Vogel", "Friedrich", "Keller", "Günther", "Berger", "Frank", "Winkler", "Roth", "Beck", "Lorenz", "Baumann", "Franke", "Albrecht", "Schuster", "Simon", "Ludwig", "Böhm", "Winter", "Kraus", "Martin", "Schumacher", "Krämer", "Vogt", "Stein", "Jäger", "Otto", "Sommer", "Seidel", "Heinrich", "Brandt", "Haas", "Schreiber", "Graf", "Dietrich", "Ziegler", "Kuhn", "Kühn", "Pohl", "Engel", "Horn", "Busch", "Bergmann", "Thomas", "Voigt", "Sauer", "Arnold", "Wolff", "Pfeiffer", "Hübner", "Reinhardt", "Kaufmann", "Kraft", "Bayer", "Ebert", "Reuter", "Adam", "Reinhard", "Schlüter", "Hinz", "Dietz", "Gebhardt", "Kessler", "Vetter", "Urban", "Wirth", "Scherer", "Barth", "Merkel", "Sander", "Schlegel", "Körner", "Heinz", "Bischof", "Brunner", "Löffler", "Fiedler", "Jansen", "Heinemann", "Körber", "Kunz", "Schmidtke", "Ritter", "Lindner", "Bock", "Anders", "Nowak", "Gerlach", "Kirsch", "Kühl", "Kilian", "Metzger", "Schütt", "Schmidt-Schwarze", "Eichhorn", "Kastner", "Sieber", "Geiger", "Schilling", "Hoppe", "Reichel", "Ulrich", "Knoll", "Kroll", "Schwab", "Rieger", "Fritz", "Wendt", "Marx", "Böhme", "Eich", "Fleischer", "Schön", "Falter", "Rupp", "Breuer", "Hilbert", "Berndt", "Voelker", "Heilmann", "Wegner", "Schramm", "Henning", "Vogler", "Schüttler", "Stark", "Thiele", "Döring", "Preuß", "Heller", "Siegel", "Krick", "Böttcher", "Römer", "Rößler", "Möbius", "Schütz", "Hartung", "Meißner", "Eisenberg", "Zorn", "Wiesner", "Morgenstern", "Münch", "Schaefer", "Hofstetter", "Hofer", "Zeller", "Selig", "Lux", "Büchner", "Stoll", "Hummel", "Kluge", "Auer", "Schupp", "Neu", "Link", "Rosenberg", "Sturm", "Voss", "Herzog", "Brenner", "Thoma", "Kästner", "Eisele", "Wacker", "Böhmler", "Lohmann", "Sanders", "Krebs", "Mader", "Brodbeck", "Förster", "Betz", "Krug", "Bär", "Heber", "Hansen", "Albrecht", "Bader", "Kröger", "Specht", "Stadler", "Schaaf", "Zimmer", "Lehnert", "Endres", "Hohmann", "Leib", "Faber", "Moll", "Fuhrmann", "Seifert", "Reimann", "Roos", "Schindler", "Rupprecht", "Bösing", "Hagel", "Strauß", "Henrich", "Mertesacker", "Pracht", "Willms", "Kochs", "Ehrlich", "Strack", "Zinn", "Steinbach", "Dreier", "Fröhlich", "Wulff", "Sattler", "Biehler", "Hering", "Klos", "Stenger", "Knappe", "Büttner", "Dörner", "Rosenthal", "Strecker", "Helbig", "Krapp", "Mertens", "Burg", "Seitz", "Göbel", "Teichmann", "Buchner", "Ahrens", "Reich", "Meissner", "Erdmann", "Ehlers", "Fischer-Büsch", "Nitsche", "Kögel", "Hellwig", "Wunderlich", "Findeisen", "Weil", "Tischer", "Rohr", "Stadtmann", "Behr", "Nickel", "Wimmer", "Schmitzer", "Lemke", "Stephan", "Birk", "Jochim", "Haberkorn", "Habermann", "Reiter", "Stolz", "Baier", "Groll", "Hager", "Evers", "Kreuzer", "Fechner", "Seemann", "Brinkmann", "Mielke", "Fink", "Heß", "Harder", "Bohnen", "Pfaff", "Leucht", "Eberle", "Arnoldt", "Greiner", "Hildebrandt", "Frenzel", "Deckert", "Burkhardt", "Flick", "Oberle", "Rohde", "Reinhart", "Wendtland", "Schwenk", "Lindemann", "Kurz", "Rath", "Hohm", "Braunwarth", "Pape", "Maas", "Grothe", "Ewert", "Kronenberg", "Engels", "Wieser", "Hermann", "Saenger", "Merk", "Esser", "Bielefeld", "Rohrer", "Bernhardt", "Heimbach", "Steinert", "Ochs", "Vornholz", "Eckhardt"
    ]
    
    static func generateRandom(gender: Gender, birthYear: Int, useAlliteration: Bool = false, useDoubleName: Bool = false) -> PersonName {
        let ageGroup = getAgeGroup(birthYear: birthYear)
        let firstNames = ageGroup.firstNames[gender] ?? []
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
    
    static func generateAlphabeticalNames(gender: Gender, birthYear: Int, useAlliteration: Bool = false, useDoubleName: Bool = false) -> [PersonName] {
        let availableLetters = Set(sampleLastNames.compactMap { $0.first }).sorted()
        var names: [PersonName] = []
        let ageGroup = getAgeGroup(birthYear: birthYear)
        let firstNames = ageGroup.firstNames[gender] ?? []
        
        for letter in availableLetters {
            let availableLastNames = sampleLastNames.filter { $0.starts(with: String(letter)) }
            
            if useAlliteration {
                let matchingFirstNames = firstNames.filter { $0.starts(with: String(letter)) }
                
                if let lastName = availableLastNames.randomElement(),
                   let firstName = matchingFirstNames.randomElement() {
                    let fullFirstName: String
                    if useDoubleName {
                        if let secondName = firstNames
                            .filter({ $0 != firstName })
                            .randomElement() {
                            fullFirstName = "\(firstName)-\(secondName)"
                        } else {
                            fullFirstName = firstName
                        }
                    } else {
                        fullFirstName = firstName
                    }
                    
                    names.append(PersonName(
                        firstName: fullFirstName,
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                }
            } else {
                if let lastName = availableLastNames.randomElement() {
                    let fullFirstName: String
                    if useDoubleName {
                        let firstName1 = firstNames.randomElement() ?? ""
                        let firstName2 = firstNames.filter { $0 != firstName1 }.randomElement() ?? ""
                        fullFirstName = "\(firstName1)-\(firstName2)"
                    } else {
                        fullFirstName = firstNames.randomElement() ?? ""
                    }
                    
                    names.append(PersonName(
                        firstName: fullFirstName,
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                }
            }
        }
        
        return names.shuffled()
    }
    
    private static func getAgeGroup(birthYear: Int) -> AgeGroup {
        let age = Calendar.current.component(.year, from: Date()) - birthYear
        
        switch age {
        case 0...12:
            return .child
        case 13...19:
            return .teenager
        case 20...30:
            return .youngAdult
        case 31...40:
            return .adult
        case 41...60:
            return .middleAge
        case 61...80:
            return .senior
        default:
            return .elderly
        }
    }
} 
