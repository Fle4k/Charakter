import SwiftUI

struct NameDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let name: GermanName
    @EnvironmentObject var nameStore: NameStore
    @State private var showingUnfavoriteAlert = false
    
    @State private var height = ""
    @State private var hairColor = ""
    @State private var eyeColor = ""
    @State private var characteristics = ""
    @State private var style = ""
    @State private var type = ""
    
    private func saveValue(_ value: String, forKey key: String) {
        UserDefaults.standard.set(value, forKey: "\(key)_\(name.id)")
    }
    
    private var hasStoredData: Bool {
        !height.isEmpty || !hairColor.isEmpty || !eyeColor.isEmpty ||
        !characteristics.isEmpty || !style.isEmpty || !type.isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                VStack(spacing: 0) {
                    DetailRow(title: "Alter:", value: "\(Calendar.current.component(.year, from: Date()) - name.birthYear)", isEditable: false)
                    DetailRow(title: "Geschlecht:", value: name.gender.rawValue, isEditable: false)
                    DetailRow(title: "Größe:", text: $height)
                    DetailRow(title: "Haarfarbe:", text: $hairColor)
                    DetailRow(title: "Augenfarbe:", text: $eyeColor)
                    DetailRow(title: "Merkmale:", text: $characteristics)
                    DetailRow(title: "Style:", text: $style)
                    DetailRow(title: "Typ:", text: $type, isLast: true)
                }
                .padding()
            }
        }
        .navigationTitle("\(name.firstName) \(name.lastName)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if hasStoredData {
                        showingUnfavoriteAlert = true
                    } else {
                        nameStore.toggleFavorite(name)
                        dismiss()
                    }
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.black)
                }
            }
        }
        .alert("Daten löschen?", isPresented: $showingUnfavoriteAlert) {
            Button("Abbrechen", role: .cancel) { }
            Button("Löschen", role: .destructive) {
                // Clear stored data
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "height_\(name.id)")
                defaults.removeObject(forKey: "hairColor_\(name.id)")
                defaults.removeObject(forKey: "eyeColor_\(name.id)")
                defaults.removeObject(forKey: "characteristics_\(name.id)")
                defaults.removeObject(forKey: "style_\(name.id)")
                defaults.removeObject(forKey: "type_\(name.id)")
                
                nameStore.toggleFavorite(name)
                dismiss()
            }
        } message: {
            Text("Wenn du diesen Namen von den Favoriten entfernst, gehen alle eingegebenen Daten verloren.")
        }
        .onShake {
            nameStore.undoDeletedName()
        }
        .onAppear {
            // Load saved values
            let defaults = UserDefaults.standard
            height = defaults.string(forKey: "height_\(name.id)") ?? ""
            hairColor = defaults.string(forKey: "hairColor_\(name.id)") ?? ""
            eyeColor = defaults.string(forKey: "eyeColor_\(name.id)") ?? ""
            characteristics = defaults.string(forKey: "characteristics_\(name.id)") ?? ""
            style = defaults.string(forKey: "style_\(name.id)") ?? ""
            type = defaults.string(forKey: "type_\(name.id)") ?? ""
        }
        .onChange(of: height) { _, value in saveValue(value, forKey: "height") }
        .onChange(of: hairColor) { _, value in saveValue(value, forKey: "hairColor") }
        .onChange(of: eyeColor) { _, value in saveValue(value, forKey: "eyeColor") }
        .onChange(of: characteristics) { _, value in saveValue(value, forKey: "characteristics") }
        .onChange(of: style) { _, value in saveValue(value, forKey: "style") }
        .onChange(of: type) { _, value in saveValue(value, forKey: "type") }
    }
}

struct DetailRow: View {
    let title: String
    var value: String = ""
    var text: Binding<String>?
    var isEditable: Bool = true
    var isLast: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.body)
                Spacer()
                if isEditable, let text = text {
                    TextField("", text: text)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(.secondary)
                        .submitLabel(.done)
                } else {
                    Text(value)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            
            if !isLast {
                Divider()
                    .padding(.leading)
            }
        }
    }
}
