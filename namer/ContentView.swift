import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @EnvironmentObject private var nameStore: NameStore
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NameGeneratorView()
                .tabItem {
                    Label("Neuer Name", systemImage: "person")
                }
                .tag(0)
            
            CollectionsView()
                .tabItem {
                    Label("Favoriten", systemImage: "star.fill")
                }
                .tag(1)
        }
        .environmentObject(nameStore)
    }
}

#Preview {
    ContentView()
        .environmentObject(NameStore())
}
