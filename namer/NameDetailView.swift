import SwiftUI
import PhotosUI

struct NameDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let name: GermanName
    @EnvironmentObject var nameStore: NameStore
    @State private var showingUnfavoriteAlert = false
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    
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
                Button {
                    showingImagePicker = true
                } label: {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Rectangle()
                            .fill(.gray.opacity(0.2))
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 30))
                                    .foregroundStyle(.gray)
                            }
                    }
                }
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
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
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

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.dismiss()
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}
