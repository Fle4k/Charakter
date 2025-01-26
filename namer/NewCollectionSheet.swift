import SwiftUI

struct NewCollectionSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var nameStore: NameStore
    @State private var collectionName = ""
    @State private var selectedNames: Set<GermanName> = []
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name der Sammlung", text: $collectionName)
                }
                
                Section {
                    ForEach(nameStore.favoriteNames) { name in
                        HStack {
                            Text("\(name.firstName) \(name.lastName)")
                            Spacer()
                            if selectedNames.contains(name) {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedNames.contains(name) {
                                selectedNames.remove(name)
                            } else {
                                selectedNames.insert(name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Neue Sammlung")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") {
                        let newCollection = NameCollection(
                            name: collectionName,
                            names: Array(selectedNames)
                        )
                        nameStore.addCollection(newCollection)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NewCollectionSheet()
        .environmentObject(NameStore())
} 
