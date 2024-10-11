import Firebase
import FirebaseFirestoreSwift

class PostService: ObservableObject {
    private var db = Firestore.firestore()

    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        print("Fetching posts...")
        db.collection("posts").order(by: "timestamp", descending: true).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion(.success([]))
                return
            }

            print("Found \(documents.count) documents")
            let posts = documents.compactMap { queryDocumentSnapshot -> Post? in
                do {
                    var post = try queryDocumentSnapshot.data(as: Post.self)
                    post.id = queryDocumentSnapshot.documentID
                    print("Successfully decoded post: \(post.id ?? "Unknown ID")")
                    return post
                } catch {
                    print("Error decoding post: \(error.localizedDescription)")
                    return nil
                }
            }
            print("Processed \(posts.count) posts")
            completion(.success(posts))
        }
    }

    func addPost(_ post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        do {
            let ref = try db.collection("posts").addDocument(from: post)
            var newPost = post
            newPost.id = ref.documentID
            print("Post added with ID: \(ref.documentID)")
            completion(.success(newPost))
        } catch {
            print("Error adding post: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    func checkFirestoreConnection() {
        db.collection("posts").limit(to: 1).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error connecting to Firestore: \(error.localizedDescription)")
            } else {
                print("Successfully connected to Firestore")
            }
        }
    }
}
