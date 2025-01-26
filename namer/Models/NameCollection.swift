import Foundation

struct NameCollection: Identifiable, Codable {
    let id: UUID
    var name: String
    var names: [GermanName]
    
    init(id: UUID = UUID(), name: String, names: [GermanName] = []) {
        self.id = id
        self.name = name
        self.names = names
    }
} 
