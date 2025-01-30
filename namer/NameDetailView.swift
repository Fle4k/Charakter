import SwiftUI
import PhotosUI

struct NameDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let name: GermanName
    @EnvironmentObject var nameStore: NameStore
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var details = PersonDetails()
    
    private var hasStoredData: Bool {
        !details.height.isEmpty ||
        !details.hairColor.isEmpty ||
        !details.eyeColor.isEmpty ||
        !details.characteristics.isEmpty ||
        !details.style.isEmpty ||
        !details.type.isEmpty ||
        selectedImage != nil
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
                    } else {
                        Rectangle()
                            .fill(.gray.opacity(0.2))
                            .frame(height: 200)
                            .overlay {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 30))
                                    .foregroundStyle(.gray)
                            }
                    }
                }
                
                Text("\(name.firstName) \(name.lastName)")
                    .font(.title2)
                    .bold()
                
                VStack(spacing: 0) {
                    DetailRow(title: "Größe:", text: Binding(
                        get: { details.height },
                        set: {
                            details.height = $0
                            nameStore.saveDetails(details, for: name)
                        }
                    ))
                    DetailRow(title: "Haarfarbe:", text: Binding(
                        get: { details.hairColor },
                        set: {
                            details.hairColor = $0
                            nameStore.saveDetails(details, for: name)
                        }
                    ))
                    DetailRow(title: "Augenfarbe:", text: Binding(
                        get: { details.eyeColor },
                        set: {
                            details.eyeColor = $0
                            nameStore.saveDetails(details, for: name)
                        }
                    ))
                    DetailRow(title: "Merkmale:", text: Binding(
                        get: { details.characteristics },
                        set: {
                            details.characteristics = $0
                            nameStore.saveDetails(details, for: name)
                        }
                    ))
                    DetailRow(title: "Style:", text: Binding(
                        get: { details.style },
                        set: {
                            details.style = $0
                            nameStore.saveDetails(details, for: name)
                        }
                    ))
                    DetailRow(title: "Typ:", text: Binding(
                        get: { details.type },
                        set: {
                            details.type = $0
                            nameStore.saveDetails(details, for: name)
                        }
                    ), isLast: true)
                }
                .padding()
            }
        }
        .navigationTitle(" ")  // Empty title
        .navigationBarTitleDisplayMode(.inline)
        .tint(.black)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .onAppear {
            details = nameStore.getDetails(for: name)
            selectedImage = nameStore.loadImage(for: name)
        }
    }
}

struct DetailRow: View {
    let title: String
    var value: String = ""
    var text: Binding<String>?
    var isEditable: Bool = true
    var isLast: Bool = false
    var onChanged: ((String) -> Void)? = nil
    
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
                        .onChange(of: text.wrappedValue) { _, newValue in
                            onChanged?(newValue)
                        }
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
