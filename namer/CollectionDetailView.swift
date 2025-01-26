import SwiftUI

struct CollectionDetailView: View {
    let collection: NameCollection
    
    var body: some View {
        List(collection.names) { name in
            Text("\(name.firstName) \(name.lastName)")
        }
        .navigationTitle(collection.name)
    }
}

#Preview {
    CollectionDetailView(collection: NameCollection(
        name: "Test Collection",
        names: [
            GermanName(firstName: "Max", lastName: "Mustermann", gender: .male, birthYear: 1990),
            GermanName(firstName: "Erika", lastName: "Musterfrau", gender: .female, birthYear: 1992)
        ]
    ))
} 
