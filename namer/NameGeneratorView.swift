import SwiftUI

struct NameGeneratorView: View {
    @State private var selectedGender: Gender = .female
    @State private var age: Int = 30
    @State private var useAlliteration = false
    @State private var useDoubleNames = false
    @State private var origin = "Deutschland"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("", selection: $selectedGender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    HStack {
                        Text("Alter")
                        Spacer()
                        Text("Geburtsjahr")
                    }
                    
                    Stepper(value: $age, in: 18...100) {
                        Text("\(age)")
                    }
                }
                
                Section {
                    HStack {
                        Text("Herkunft")
                        Spacer()
                        Text(origin)
                    }
                }
                
                Section {
                    Toggle("Alliteration", isOn: $useAlliteration)
                    Toggle("Doppelnamen", isOn: $useDoubleNames)
                }
                
                Section {
                    Button(action: generateName) {
                        Text("Namen Generieren!")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color.blue)
                }
            }
            .navigationTitle("Name")
        }
    }
    
    private func generateName() {
        // Implementation will come later
    }
}