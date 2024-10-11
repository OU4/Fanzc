import Foundation
import Firebase
import FirebaseStorage

class SwarmPostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var postService = PostService()

    func createPost(content: String, location: Location, image: UIImage?) {
        guard let user = Auth.auth().currentUser else {
            print("No user logged in")
            return
        }

        var mediaURL: String?
        
        let group = DispatchGroup()
        
        if let image = image {
            group.enter()
            uploadImage(image) { result in
                switch result {
                case .success(let url):
                    mediaURL = url
                case .failure(let error):
                    print("Error uploading image: \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            let newPost = Post(
                authorID: user.uid,
                authorName: user.displayName ?? "Unknown User",
                authorProfilePictureURL: user.photoURL?.absoluteString ?? "",
                content: content,
                timestamp: Date(),
                mediaURL: mediaURL,
                likes: 0,
                comments: [],
                currentUserLiked: false,
                locationName: location.name,
                locationDetails: location.details
            )
            
            self.postService.addPost(newPost) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let post):
                        self?.posts.insert(post, at: 0)
                        print("Post added successfully with ID: \(post.id ?? "unknown")")
                    case .failure(let error):
                        print("Error adding post: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    private func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        let storageRef = Storage.storage().reference().child("post_images/\(UUID().uuidString).jpg")
        
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
    }

    func fetchPosts() {
        postService.fetchPosts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedPosts):
                    self?.posts = fetchedPosts
                case .failure(let error):
                    print("Error fetching posts: \(error.localizedDescription)")
                }
            }
        }
    }
}
