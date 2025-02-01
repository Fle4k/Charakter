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
        !details.hashtag.isEmpty ||
        selectedImage != nil
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                GeometryReader { geo in
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width)
                            .frame(height: 300)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: geo.size.width)
                            .frame(height: 300)
                    }
                }
                .frame(height: 300)
                .contextMenu {
                    Button {
                        showingImagePicker = true
                    } label: {
                        Label("Foto hinzufügen", systemImage: "photo")
                    }
                    
                    if selectedImage != nil {
                        Button(role: .destructive) {
                            selectedImage = nil
                            nameStore.deleteImage(for: name)
                        } label: {
                            Label("Foto löschen", systemImage: "trash")
                        }
                    }
                    
                    Button(role: .destructive) {
                        nameStore.toggleFavorite(name)
                        dismiss()
                    } label: {
                        Label("Von Favoriten entfernen", systemImage: "star.slash")
                    }
                }
                
                Text("\(name.firstName) \(name.lastName)")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color.dynamicText)
                    .padding(.top, -10)  // Adjust spacing after the image area
                
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
                    ))
                    DetailRow(title: "# :", text: Binding(
                        get: { details.hashtag },
                        set: {
                            details.hashtag = $0
                            nameStore.saveDetails(details, for: name)
                        }
                    ), placeholder: "z.B. Projektname", isLast: true)
                }
                .padding()
            }
            .padding(.top, 0)
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        showingImagePicker = true
                    } label: {
                        Label("Foto hinzufügen", systemImage: "photo")
                    }
                    
                    if selectedImage != nil {
                        Button(role: .destructive) {
                            selectedImage = nil
                            nameStore.deleteImage(for: name)
                        } label: {
                            Label("Foto löschen", systemImage: "trash")
                        }
                    }
                    
                    Button(role: .destructive) {
                        nameStore.toggleFavorite(name)
                        dismiss()
                    } label: {
                        Label("Von Favoriten entfernen", systemImage: "star.slash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Color.dynamicText)
                }
            }
        }
        .tint(Color.dynamicText)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage) { image in
                nameStore.saveImage(image, for: name)
            }
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
    var placeholder: String = ""
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
                    TextField(placeholder, text: text)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(Color.dynamicText.opacity(0.6))
                        .submitLabel(.done)
                        .onChange(of: text.wrappedValue) { _, newValue in
                            onChanged?(newValue)
                        }
                } else {
                    Text(value)
                        .foregroundStyle(Color.dynamicText.opacity(0.6))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            
            if !isLast {
                Divider()
                    .background(Color.dynamicText.opacity(0.2))
                    .padding(.leading)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss
    let onImageSelected: ((UIImage) -> Void)?
    
    init(image: Binding<UIImage?>, onImageSelected: ((UIImage) -> Void)? = nil) {
        _image = image
        self.onImageSelected = onImageSelected
    }
    
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
                        if let image = image as? UIImage {
                            self.parent.image = image
                            self.parent.onImageSelected?(image)
                        }
                    }
                }
            }
        }
    }
}
