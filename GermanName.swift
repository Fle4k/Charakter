//
//  GermanName.swift
//  Namer
//
//  Created by Shahin on 26.01.25.
//


import Foundation

struct GermanName: Identifiable, Codable, Hashable {
    let id = UUID()
    let firstName: String
    let lastName: String
    let gender: Gender
    let birthYear: Int
    
    enum Gender: String, Codable, CaseIterable {
        case male = "Männlich"
        case female = "Weiblich"
    }
}

struct NameCollection: Identifiable, Codable {
    let id = UUID()
    var name: String
    var names: [GermanName]
}

enum AgeGroup: CaseIterable {
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
        case 31...45: return .adult
        case 46...60: return .middleAge
        case 61...75: return .senior
        default: return .elderly
        }
    }
}