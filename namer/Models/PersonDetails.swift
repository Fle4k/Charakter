//
//  PersonDetails.swift
//  Namer
//
//  Created by Shahin on 27.01.25.
//


import Foundation

struct PersonDetails: Codable {
    var height: String
    var hairColor: String
    var eyeColor: String
    var characteristics: String
    var style: String
    var type: String
    
    init() {
        self.height = ""
        self.hairColor = ""
        self.eyeColor = ""
        self.characteristics = ""
        self.style = ""
        self.type = ""
    }
} 