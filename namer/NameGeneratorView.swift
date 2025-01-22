import SwiftUI

struct NameGeneratorView: View {
    @EnvironmentObject private var nameStore: NameStore
    @State private var selectedGender: PersonName.Gender = .female
    @State private var selectedAgeGroup: AgeGroup = .youngAdult
    @State private var useAlliteration = false
    @State private var useDoubleNames = false
    @State private var generatedNames: [PersonName] = []
    @State private var showingResult = false
    @State private var isGeneratingNames = false
    
    enum AgeGroup: String, CaseIterable {
        case toddler = "Kleinkinder"
        case child = "Kinder"
        case teenager = "Teenager"
        case youngAdult = "Junge Erwachsene"
        case adult = "Erwachsene"
        case middleAge = "Mittleres Erwachsenenalter"
        case senior = "SeniorInnen"
        case elderly = "Hochbetagte"
        
        var averageAge: Int {
            switch self {
            case .toddler: return 2
            case .child: return 8
            case .teenager: return 16
            case .youngAdult: return 25
            case .adult: return 35
            case .middleAge: return 50
            case .senior: return 65
            case .elderly: return 80
            }
        }
    }
    
    private var birthYear: Int {
        Calendar.current.component(.year, from: Date()) - selectedAgeGroup.averageAge
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Gender Section
                Section {
                    Picker("", selection: $selectedGender) {
                        ForEach(PersonName.Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .cleanSegmentedStyle()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                
                // Age Section
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Alter")
                            .font(.headline)
                        Picker("", selection: $selectedAgeGroup) {
                            ForEach(AgeGroup.allCases, id: \.self) { group in
                                Text(group.rawValue).tag(group)
                            }
                        }
                        .pickerStyle(.wheel)
                        
                        Text("Geburtsjahr \(String(format: "%d", birthYear))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                // Options Section
                Section {
                    Toggle("Alliteration", isOn: $useAlliteration)
                    Toggle("Doppelnamen", isOn: $useDoubleNames)
                }
                
                // Generate Button Section
                Section {
                    Button(action: generateNames) {
                        if isGeneratingNames {
                            ProgressView()
                        } else {
                            Text("Namen Generieren!")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(isGeneratingNames)
                    .listRowBackground(Color.accentColor)
                }
            }
            .navigationTitle("Name")
        }
        .sheet(isPresented: $showingResult) {
            NavigationView {
                GeneratedNamesListView(names: generatedNames)
                    .environmentObject(nameStore)
            }
        }
    }
    
    private func generateNames() {
        isGeneratingNames = true
        generatedNames = []  // Clear existing names
        
        // Generate alphabetical names
        let names = PersonName.generateAlphabeticalNames(
            gender: selectedGender,
            birthYear: birthYear,
            useAlliteration: useAlliteration,
            useDoubleName: useDoubleNames
        )
        
        generatedNames = names
        showingResult = true
        isGeneratingNames = false
    }
}

struct CleanSegmentedPickerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .pickerStyle(.segmented)
            .padding(-8)
            .background(.clear)
            .tint(.blue)
    }
}

extension View {
    func cleanSegmentedStyle() -> some View {
        self.modifier(CleanSegmentedPickerStyle())
    }
}

#Preview {
    NameGeneratorView()
        .environmentObject(NameStore())
}
