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