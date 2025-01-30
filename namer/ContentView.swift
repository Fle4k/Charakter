import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isDrawerPresented = false
    @State private var hasGeneratedNames = false
    @EnvironmentObject private var nameStore: NameStore
    @StateObject private var viewModel = GeneratorViewModel()
    
    init() {
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NameGeneratorView(isDrawerPresented: $isDrawerPresented,
                             hasGeneratedNames: $hasGeneratedNames,
                             viewModel: viewModel)
                .tabItem {
                    Label("Neuer Name", systemImage: "person")
                }
                .tag(0)
            
            if hasGeneratedNames {
                NavigationStack {
                    GeneratedNamesListView(
                        names: viewModel.generatedNamesList?.names ?? [],
                        sheetDetent: .constant(.large)
                    )
                    .environmentObject(nameStore)
                }
                .tabItem {
                    Label("Historie", systemImage: isDrawerPresented ? "person.badge.clock.fill" : "person.badge.clock")
                }
                .tag(1)
            }
            
            CollectionsView()
                .tabItem {
                    Label("Favoriten", systemImage: "star.fill")
                }
                .tag(hasGeneratedNames ? 2 : 1)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NameStore())
}
