import SwiftUI

struct NameDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let name: GermanName
    @EnvironmentObject var nameStore: NameStore
    @State private var height = ""
    @State private var hairColor = ""
    @State private var eyeColor = ""
    @State private var characteristics = ""
    @State private var style = ""
    @State private var type = ""
    
    func isNameInFavorites(_ name: GermanName) -> Bool {
        nameStore.favoriteNames.contains(where: {
            $0.firstName == name.firstName &&
            $0.lastName == name.lastName &&
            $0.gender == name.gender &&
            $0.birthYear == name.birthYear
        })
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Placeholder for future image section
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
                        DetailRow(title: "Typ:", text: $type)
                    }
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                }
            }
            
            Button {
                nameStore.deleteGeneratedName(name)
                dismiss()
            } label: {
                Text("Name löschen")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
        .navigationTitle("\(name.firstName) \(name.lastName)")
        .navigationBarTitleDisplayMode(.inline)
        .onShake {
            nameStore.undoDeletedName()
        }
    }
}

struct DetailRow: View {
    let title: String
    var value: String = ""
    var text: Binding<String>?
    var isEditable: Bool = true
    
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
                } else {
                    Text(value)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            
            Divider()
                .padding(.leading)
        }
    }
} 
