import SwiftUI

struct CustomSegmentedPickerStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.dynamicFill)
                UISegmentedControl.appearance().setTitleTextAttributes(
                    [.foregroundColor: UIColor(Color.dynamicBackground)],
                    for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes(
                    [.foregroundColor: UIColor(Color.dynamicText)],
                    for: .normal)
            }
    }
}

struct NameGeneratorView: View {
    @EnvironmentObject var nameStore: NameStore
    @ObservedObject var viewModel: GeneratorViewModel
    @State private var selectedGender: GermanName.NameGender = .female
    @State private var selectedAgeGroup: AgeGroup = .youngAdult
    @State private var allowDoppelnamen = false
    @State private var allowAlliteration = false
    @State private var restrictAge = false
    @State private var sheetDetent: PresentationDetent = .large
    @Binding var isDrawerPresented: Bool
    @Binding var hasGeneratedNames: Bool
    @Environment(\.colorScheme) var colorScheme
    
    init(isDrawerPresented: Binding<Bool>,
         hasGeneratedNames: Binding<Bool>,
         viewModel: GeneratorViewModel) {
        _isDrawerPresented = isDrawerPresented
        _hasGeneratedNames = hasGeneratedNames
        self.viewModel = viewModel
    }
    
    var birthYear: Int {
        let currentYear = Calendar.current.component(.year, from: Date())
        switch selectedAgeGroup {
        case .child: return currentYear - 5
        case .teenager: return currentYear - 15
        case .youngAdult: return currentYear - 25
        case .adult: return currentYear - 35
        case .middleAge: return currentYear - 50
        case .senior: return currentYear - 70
        case .elderly: return currentYear - 85
        }
    }
    
    var toggleTint: Color {
        colorScheme == .dark ? Color.dynamicText.opacity(0.6) : Color.dynamicFill
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    Spacer()
                        .frame(height: geometry.size.height * 0.08)  // 8% of screen height
                    
                    // Gender Picker
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(GermanName.NameGender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(.segmented)
                    .modifier(CustomSegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    Spacer()
                        .frame(height: geometry.size.height * 0.04)  // 4% spacing between picker and toggles
                    
                    // Toggles in top third
                    VStack(spacing: 0) {
                        Toggle("Alliteration", isOn: $allowAlliteration)
                            .padding()
                            .tint(toggleTint)
                            .foregroundStyle(Color.dynamicText)
                        
                        Divider()  // Keep only one divider
                            .background(Color.dynamicText.opacity(0.2))  // Make it slightly transparent
                        
                        Toggle("Doppelnamen", isOn: $allowDoppelnamen)
                            .padding()
                            .tint(toggleTint)
                            .foregroundStyle(Color.dynamicText)
                        
                        Divider()  // Keep only one divider
                            .background(Color.dynamicText.opacity(0.2))
                        
                        Toggle("Auf Alter beschränken", isOn: $restrictAge)
                            .padding()
                            .tint(toggleTint)
                            .foregroundStyle(Color.dynamicText)
                    }
                    .padding(.horizontal)
                    
                    if restrictAge {
                        VStack(spacing: 8) {
                            Picker("Age", selection: $selectedAgeGroup) {
                                Text("Kleinkinder").tag(AgeGroup.child)
                                    .foregroundStyle(Color.dynamicText)
                                Text("Kinder").tag(AgeGroup.child)
                                    .foregroundStyle(Color.dynamicText)
                                Text("Teenager").tag(AgeGroup.teenager)
                                    .foregroundStyle(Color.dynamicText)
                                Text("Junge Erwachsene").tag(AgeGroup.youngAdult)
                                    .foregroundStyle(Color.dynamicText)
                                Text("Erwachsene").tag(AgeGroup.adult)
                                    .foregroundStyle(Color.dynamicText)
                                Text("Mittleres Erwachsenenalter").tag(AgeGroup.middleAge)
                                    .foregroundStyle(Color.dynamicText)
                                Text("SeniorInnen").tag(AgeGroup.senior)
                                    .foregroundStyle(Color.dynamicText)
                                Text("Hochbetagte").tag(AgeGroup.elderly)
                                    .foregroundStyle(Color.dynamicText)
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 150)
                            
                            Text(decadeText(for: birthYear))
                                .font(.subheadline)
                                .foregroundStyle(Color.dynamicText.opacity(0.6))
                                .padding()
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    // Generate Button
                    Button(action: generateAndShowNames) {
                        Text("Namen Generieren")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.dynamicFill)
                            .foregroundColor(Color.dynamicBackground)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, geometry.size.height * 0.05)  // 5% of screen height
                }
            }
        }
        .tint(Color.dynamicText)
        .sheet(isPresented: $isDrawerPresented) {
            NavigationStack {
                VStack(spacing: 0) {
                    Color.clear.frame(height: 60)
                    
                    GeneratedNamesListView(
                        names: viewModel.generatedNamesList?.names ?? [],
                        sheetDetent: $sheetDetent
                    )
                    .environmentObject(nameStore)
                    .tint(Color.dynamicText)
                }
            }
            .presentationDetents([.large], selection: $sheetDetent)
            .presentationDragIndicator(.visible)
            .presentationBackgroundInteraction(.enabled)
            .tint(Color.dynamicText)
        }
    }
    
    private func getAgeGroupTitle() -> String {
        switch selectedAgeGroup {
        case .child: return "Kinder"
        case .teenager: return "Teenager"
        case .youngAdult: return "Junge Erwachsene"
        case .adult: return "Erwachsene"
        case .middleAge: return "Mittleres Erwachsenenalter"
        case .senior: return "SeniorInnen"
        case .elderly: return "Hochbetagte"
        }
    }
    
    private func generateAndShowNames() {
        let names = GermanName.generateNames(
            gender: selectedGender,
            birthYear: restrictAge ? birthYear : Calendar.current.component(.year, from: Date()) - 25,
            useAlliteration: allowAlliteration,
            useDoubleName: allowDoppelnamen
        )
        
        viewModel.addNamesToHistory(names)
        isDrawerPresented = true
        hasGeneratedNames = true
        print("Generated \(names.count) names")
    }
    
    private func decadeText(for year: Int) -> String {
        let decade = (year / 10) * 10
        return "geboren in den \(decade)ern"
    }
}

#Preview {
    NameGeneratorView(isDrawerPresented: .constant(false), hasGeneratedNames: .constant(false), viewModel: GeneratorViewModel())
        .environmentObject(NameStore())
}
