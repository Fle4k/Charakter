import SwiftUI

struct CollectionsView: View {
    @State private var favoriteNames: [Name] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(groupedNames.keys.sorted(), id: \.self) { letter in
                    Section(header: Text(letter)) {
                        ForEach(groupedNames[letter] ?? []) { name in
                            NameRow(name: name)
                        }
                    }
                }
            }
            .navigationTitle("Neue Namen")
        }
    }
    
    private var groupedNames: [String: [Name]] {
        Dictionary(grouping: favoriteNames) { name in
            String(name.lastName.prefix(1))
        }
    }
}

struct NameRow: View {
    let name: Name
    
    var body: some View {
        HStack {
            Text("\(name.firstName) \(name.lastName)")
            Spacer()
            if name.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.blue)
            }
        }
    }
}