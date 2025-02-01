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
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.dynamicText)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes =
            [.foregroundColor: UIColor(Color.dynamicText)]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                NameGeneratorView(
                    isDrawerPresented: $isDrawerPresented,
                    hasGeneratedNames: $hasGeneratedNames,
                    viewModel: viewModel
                )
            }
            .tint(Color.dynamicText)
            .tabItem {
                Label("Neuer Name", systemImage: "person")
            }
            .tag(0)
            .gesture(
                DragGesture()
                    .onEnded { gesture in
                        if gesture.translation.width < -50 {
                            withAnimation {
                                selectedTab = min(selectedTab + 1, 2)
                            }
                        } else if gesture.translation.width > 50 {
                            withAnimation {
                                selectedTab = max(selectedTab - 1, 0)
                            }
                        }
                    }
            )
            
            NavigationStack {
                GeneratedNamesListView(
                    names: viewModel.nameHistory,
                    sheetDetent: .constant(.large)
                )
                .environmentObject(nameStore)
                .overlay {
                    if viewModel.nameHistory.isEmpty {
                        ContentUnavailableView {
                            Label("Keine Namen generiert", systemImage: "person.badge.clock")
                                .foregroundStyle(Color.dynamicText)
                                .font(.body.weight(.regular))
                        }
                    }
                }
            }
            .tint(Color.dynamicText)
            .tabItem {
                Label("Historie", systemImage: "person.badge.clock")
            }
            .tag(1)
            .gesture(
                DragGesture()
                    .onEnded { gesture in
                        if gesture.translation.width < -50 {
                            withAnimation {
                                selectedTab = min(selectedTab + 1, 2)
                            }
                        } else if gesture.translation.width > 50 {
                            withAnimation {
                                selectedTab = max(selectedTab - 1, 0)
                            }
                        }
                    }
            )
            
            NavigationStack {
                CollectionsView()
            }
            .tint(Color.dynamicText)
            .tabItem {
                Label("Favoriten", systemImage: "star.fill")
            }
            .tag(2)
            .gesture(
                DragGesture()
                    .onEnded { gesture in
                        if gesture.translation.width < -50 {
                            withAnimation {
                                selectedTab = min(selectedTab + 1, 2)
                            }
                        } else if gesture.translation.width > 50 {
                            withAnimation {
                                selectedTab = max(selectedTab - 1, 0)
                            }
                        }
                    }
            )
        }
        .tabViewStyle(.automatic)
        .animation(.easeInOut(duration: 0.3), value: selectedTab)
    }
}

#Preview {
    ContentView()
        .environmentObject(NameStore())
}

