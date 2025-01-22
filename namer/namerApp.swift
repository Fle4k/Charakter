import SwiftUI

@main
struct namerApp: App {
    @StateObject private var nameStore = NameStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(nameStore)
        }
    }
} 
