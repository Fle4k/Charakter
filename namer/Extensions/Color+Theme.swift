import SwiftUI

extension Color {
    static var dynamicText: Color {
        Color(.label)  // Automatically adapts to light/dark mode
    }
    
    static var dynamicBackground: Color {
        Color(.systemBackground)  // Automatically adapts to light/dark mode
    }
    
    static var dynamicFill: Color {
        Color(.label)  // Same as text color, inverts automatically
    }
} 
