import SwiftUI

@main
struct NamerApp: App {
    @StateObject private var nameStore = NameStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(nameStore)
                .tint(Color.dynamicText)
        }
    }
} 
