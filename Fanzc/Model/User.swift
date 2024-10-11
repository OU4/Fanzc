import Foundation
import FirebaseAuth
import Firebase

struct User: Codable {
    let id: String
    var username: String  // Changed to var
    var bio: String       // Changed to var
    var profilePictureURL: String?
    
    // User initializer
    init(id: String, username: String, bio: String, profilePictureURL: String? = nil) {
        self.id = id
        self.username = username
        self.bio = bio
        self.profilePictureURL = profilePictureURL
    }

    // Initializer for creating a User from FirebaseAuth.User
    init(firebaseUser: FirebaseAuth.User) {
        self.id = firebaseUser.uid
        self.username = firebaseUser.displayName ?? "Unknown"
        self.bio = "" // or fetch from another source or Firestore
        self.profilePictureURL = firebaseUser.photoURL?.absoluteString
    }
    
    // This method should be moved outside the struct as it's not a property or method of User
    static func fetchFirestoreUserProfile(for userID: String, completion: @escaping (User?) -> Void) {
        Firestore.firestore().collection("users").document(userID).getDocument { document, error in
            if let document = document, document.exists, let data = document.data() {
                let id = data["id"] as? String ?? userID
                let username = data["username"] as? String ?? "Unknown"
                let bio = data["bio"] as? String ?? ""
                let profilePictureURL = data["profilePictureURL"] as? String
                
                let user = User(id: id, username: username, bio: bio, profilePictureURL: profilePictureURL)
                completion(user)
            } else {
                print("Error fetching user data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case bio
        case profilePictureURL
    }
}
