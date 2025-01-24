struct NewCollectionView: View {
    @EnvironmentObject private var nameStore: NameStore
    @Binding var isPresented: Bool
    @State private var collectionName = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Name der Sammlung", text: $collectionName)
            }
        }
        .navigationTitle("Neue Sammlung")
        .navigationBarItems(
            leading: Button("Abbrechen") {
                isPresented = false
            },
            trailing: Button("Fertig") {
                if !collectionName.isEmpty {
                    nameStore.addCollection(NameCollection(name: collectionName))
                    isPresented = false
                }
            }
            .disabled(collectionName.isEmpty)
        )
    }
} 