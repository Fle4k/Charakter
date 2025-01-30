import SwiftUI

struct CustomSegmentedPickerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UISegmentedControl.appearance().selectedSegmentTintColor = .black
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
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
                            .tint(.black)
                        
                        Divider()
                            .padding(.horizontal)
                            .background(.black)
                        
                        Toggle("Doppelnamen", isOn: $allowDoppelnamen)
                            .padding()
                            .tint(.black)
                        
                        Divider()
                            .padding(.horizontal)
                            .background(.black)
                        
                        Toggle("Auf Alter beschränken", isOn: $restrictAge)
                            .padding()
                            .tint(.black)
                    }
                    .padding(.horizontal)
                    
                    if restrictAge {
                        VStack(spacing: 8) {
                            Picker("Age", selection: $selectedAgeGroup) {
                                Text("Kleinkinder").tag(AgeGroup.child)
                                Text("Kinder").tag(AgeGroup.child)
                                Text("Teenager").tag(AgeGroup.teenager)
                                Text("Junge Erwachsene").tag(AgeGroup.youngAdult)
                                Text("Erwachsene").tag(AgeGroup.adult)
                                Text("Mittleres Erwachsenenalter").tag(AgeGroup.middleAge)
                                Text("SeniorInnen").tag(AgeGroup.senior)
                                Text("Hochbetagte").tag(AgeGroup.elderly)
                            }
                            .pickerStyle(.wheel)
                            
                            Text(decadeText(for: birthYear))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .padding()
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    // Generate Button
                    Button(action: generateAndShowNames) {
                        Text("Namen Generieren!")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, geometry.size.height * 0.05)  // 5% of screen height
                }
            }
        }
        .sheet(isPresented: $isDrawerPresented) {
            NavigationStack {
                GeneratedNamesListView(
                    names: viewModel.generatedNamesList?.names ?? [],
                    sheetDetent: $sheetDetent
                )
                .environmentObject(nameStore)
                .tint(.black)
            }
            .presentationDetents([.large], selection: $sheetDetent)
            .presentationDragIndicator(.visible)
            .presentationBackgroundInteraction(.enabled)
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
        
        viewModel.generatedNamesList = GeneratedNamesList(names: names)
        isDrawerPresented = true
        hasGeneratedNames = true
        print("Generated \(names.count) names")
    }
    
    private func decadeText(for year: Int) -> String {
        let decade = (year / 10) * 10
        return "geboren in den \(decade)ern"
    }
}

class GeneratorViewModel: ObservableObject {
    @Published var generatedNamesList: GeneratedNamesList?
}

struct GeneratedNamesList: Identifiable {
    let id = UUID()
    let names: [GermanName]
}

#Preview {
    NameGeneratorView(isDrawerPresented: .constant(false), hasGeneratedNames: .constant(false), viewModel: GeneratorViewModel())
        .environmentObject(NameStore())
}
