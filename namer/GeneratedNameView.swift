import SwiftUI

struct GeneratedNameView: View {
    let name: PersonName
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var nameStore: NameStore
    
    init(name: PersonName) {
        self.name = name
    }
    
    var body: some View {
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
                nameStore.toggleFavorite(name)
            }) {
                Label(
                    nameStore.favoriteNames.contains(where: { $0.id == name.id })
                        ? "Von Favoriten entfernen"
                        : "Zu Favoriten hinzufügen",
                    systemImage: nameStore.favoriteNames.contains(where: { $0.id == name.id })
                        ? "star.fill"
                        : "star"
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

#Preview {
    NavigationView {
        GeneratedNameView(name: PersonName(
            firstName: "Andrea",
            lastName: "Christ",
            gender: .female,
            birthYear: 1990
        ))
        .environmentObject(NameStore())
    }
} 
