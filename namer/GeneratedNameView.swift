import SwiftUI

struct GeneratedNameView: View {
    let name: PersonName
    @Environment(\.dismiss) private var dismiss
    @Binding var isFavorite: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("\(name.firstName) \(name.lastName)")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Gender: \(name.gender.rawValue)")
                    Text("Jahrgang: \(name.birthYear)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Label(
                        isFavorite ? "Von Favoriten entfernen" : "Zu Favoriten hinzufügen",
                        systemImage: isFavorite ? "star.fill" : "star"
                    )
                }
                .buttonStyle(.bordered)
                
                Button("Neuer Name", action: dismiss.callAsFunction)
                    .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Generierter Name")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}