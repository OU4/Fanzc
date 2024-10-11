import SwiftUI

struct SwarmPostCreationView: View {
    @ObservedObject var viewModel: SwarmPostViewModel
    @State private var content = ""
    @State private var selectedLocation: Location?
    @State private var isShowingLocationPicker = false
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Location selection
                Button(action: {
                    isShowingLocationPicker = true
                }) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(selectedLocation?.name ?? "Choose a location")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .foregroundColor(.orange)
                }
                
                // Content input area
                VStack(alignment: .leading, spacing: 10) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                    
                    TextEditor(text: $content)
                        .frame(height: 100)
                        .padding(5)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    
                    HStack {
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            Image(systemName: "photo")
                                .foregroundColor(.blue)
                        }
                        
                        Button(action: {
                            // Add functionality for adding a view
                        }) {
                            Image(systemName: "eye")
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        Text("\(content.count)/280")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 5)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("Create Post", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Post") {
                    if let location = selectedLocation {
                        viewModel.createPost(content: content, location: location, image: selectedImage)
                        dismiss()
                    }
                }
                .disabled(content.isEmpty || selectedLocation == nil)
            )
        }
        .sheet(isPresented: $isShowingLocationPicker) {
            LocationPickerView(selectedLocation: $selectedLocation)
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
}
struct LocationPickerView: View {
    @Binding var selectedLocation: Location?
    @Environment(\.dismiss) var dismiss
    
    let locations = [
        Location(name: "Dhahban", details: "City", distance: "2"),
        Location(name: "Obhur Alshmalyyah", details: "3.5 km", distance: "7"),
        Location(name: "مكان عجيب", details: "1.2 km", distance: ""),
        Location(name: "BAE Systems", details: "300 m", distance: ""),
        Location(name: "Oia Beach", details: "Obhur Rd", distance: "4.9 km 3")
    ]

    var body: some View {
        NavigationView {
            List(locations) { location in
                Button(action: {
                    selectedLocation = location
                    dismiss()
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(location.name)
                                .font(.headline)
                            Text(location.details)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if !location.distance.isEmpty {
                            Text(location.distance)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Choose Location")
            .navigationBarItems(leading: Button("Cancel") { dismiss() })
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SwarmPostCreationView_Previews: PreviewProvider {
    static var previews: some View {
        SwarmPostCreationView(viewModel: SwarmPostViewModel())
    }
}
