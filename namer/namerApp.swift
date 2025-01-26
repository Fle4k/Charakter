import SwiftUI

@main
struct NamerApp: App {
    @StateObject private var nameStore = NameStore()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NameGeneratorView()
                    .tabItem {
                        Label("Neuer Name", systemImage: "person")
                    }
                
                CollectionsView()
                    .tabItem {
                        Label("Favoriten", systemImage: "star")
                    }
            }
            .environmentObject(nameStore)
        }
    }
} 
