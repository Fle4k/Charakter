import Foundation

struct PersonDetails: Codable {
    var notes: String = ""
    var images: [Data] = []
    var height: String
    var hairColor: String
    var eyeColor: String
    var characteristics: String
    var style: String
    var type: String
    var hashtag: String
    
    init() {
        self.height = ""
        self.hairColor = ""
        self.eyeColor = ""
        self.characteristics = ""
        self.style = ""
        self.type = ""
        self.hashtag = ""
    }
} 
