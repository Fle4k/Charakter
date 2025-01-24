import Foundation

struct NameCollection: Identifiable, Codable {
    let id: UUID
    var name: String
    var names: [PersonName]
    
    init(id: UUID = UUID(), name: String, names: [PersonName] = []) {
        self.id = id
        self.name = name
        self.names = names
    }
} 