import SwiftUI

struct NameGeneratorView: View {
    @EnvironmentObject var nameStore: NameStore
    @State private var showingGeneratedNames = false
    @State private var selectedGender: GermanName.Gender = .female
    @State private var selectedAgeGroup: AgeGroup = .youngAdult
    @State private var allowDoppelnamen = false
    @State private var allowAlliteration = false
    @StateObject private var viewModel = GeneratorViewModel()
    
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
        VStack(spacing: 20) {
            // Gender Picker
            Picker("Gender", selection: $selectedGender) {
                ForEach(GermanName.Gender.allCases, id: \.self) { gender in
                    Text(gender.rawValue).tag(gender)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            // Age Group Section
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
                
                Text("Geburtsjahr \(birthYear, format: .number.grouping(.never))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Toggles
            VStack(spacing: 1) {
                Toggle("Alliteration", isOn: $allowAlliteration)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .tint(.black)
                
                Toggle("Doppelnamen", isOn: $allowDoppelnamen)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .tint(.black)
            }
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Generate Button
            Button(action: generateAndShowNames) {
                Text("Namen Generieren!")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showingGeneratedNames) {
            NavigationStack {
                GeneratedNamesListView(names: viewModel.generatedNames)
                    .environmentObject(nameStore)
            }
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
        viewModel.generatedNames = GermanName.generateNames(
            count: 50,
            gender: selectedGender,
            birthYear: birthYear,
            useAlliteration: allowAlliteration,
            useDoubleName: allowDoppelnamen
        )
        
        print("Generated \(viewModel.generatedNames.count) names")
        showingGeneratedNames = true
    }
}

class GeneratorViewModel: ObservableObject {
    @Published var generatedNames: [GermanName] = []
}

#Preview {
    NameGeneratorView()
        .environmentObject(NameStore())
}
