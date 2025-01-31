import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isDrawerPresented = false
    @State private var hasGeneratedNames = false
    @EnvironmentObject private var nameStore: NameStore
    @StateObject private var viewModel = GeneratorViewModel()
    @State private var shouldPulse = false
    
    init() {
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.dynamicText)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes =
            [.foregroundColor: UIColor(Color.dynamicText)]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NameGeneratorView(
                isDrawerPresented: $isDrawerPresented,
                hasGeneratedNames: $hasGeneratedNames,
                viewModel: viewModel
            )
                .tint(Color.dynamicText)
                .tabItem {
                    Label("Neuer Name", systemImage: "person")
                }
                .tag(0)
            
            NavigationStack {
                GeneratedNamesListView(
                    names: viewModel.nameHistory,
                    sheetDetent: .constant(.large)
                )
                .environmentObject(nameStore)
            }
            .tint(Color.dynamicText)
            .tabItem {
                HStack {
                    Image(systemName: isDrawerPresented ? "person.badge.clock.fill" : "person.badge.clock")
                        .symbolEffect(.pulse, options: .repeat(3), value: shouldPulse)
                    Text("Historie")
                }
            }
            .tag(1)
            .onChange(of: isDrawerPresented) { _, isPresented in
                if !isPresented {
                    shouldPulse.toggle()
                }
            }
            
            CollectionsView()
                .tint(Color.dynamicText)
                .tabItem {
                    Label("Favoriten", systemImage: "star.fill")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NameStore())
}

