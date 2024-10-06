import SwiftUI

struct PostCreationView: View {
    @State private var caption = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    
                    ProfileImageView()
                    

                    // Text field for the new post
                    TextField("What's new?", text: $caption)
                        .frame(minHeight: 20)

                    // Dismiss button
                    
                    if !caption.isEmpty{
                        
                        Button {
                      
                            caption = ""
                            
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                        
                        
                        
                    }
                    
                    
                   
                }
               

                // Icons for adding media or other content to the post
                HStack(spacing: 25) { // Spacing can be adjusted as needed
                    ForEach(PostCreationOptions.allCases, id: \.self) { option in
                        Button(action: {
                            // Action for each option
                        }) {
                            Image(systemName: option.iconName)
                                .font(.title2)
                                .foregroundColor(Color(UIColor.systemGray3))
                        }
                    }
                }
                .padding()

                Spacer()
            }
            .padding()
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel", action: {
                    dismiss()
                }),
                trailing: Button("Post", action: {
                    // Action for post button
                })
                .opacity(caption.isEmpty ? 0.5 : 1.0)
                .disabled(caption.isEmpty)
                
            )
            .foregroundStyle(.black)
        }
    }
}

enum PostCreationOptions: CaseIterable {
    case photo, video
    
    var iconName: String {
        switch self {
        case .photo:
            return "photo"
        case .video:
            return "video"
        }
    }
}

struct PostCreationView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreationView()
    }
}

