import SwiftUI

struct NewCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var nameStore: NameStore
    @State private var collectionName = ""
    
    var body: some View {
        Form {
            TextField("Name der Sammlung", text: $collectionName)
        }
        .navigationTitle("Neue Sammlung")
        .navigationBarItems(
            leading: Button("Abbrechen") {
                dismiss()
            },
            trailing: Button("Fertig") {
                if !collectionName.isEmpty {
                    let newCollection = NameCollection(name: collectionName)
                    nameStore.addCollection(newCollection)
                    dismiss()
                }
            }
            .disabled(collectionName.isEmpty)
        )
    }
}

#Preview {
    NavigationView {
        NewCollectionView()
            .environmentObject(NameStore())
    }
} 
