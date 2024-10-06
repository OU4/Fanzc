import Foundation
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: User
       @Published var totalCheckIns: Int = 0
       @Published var categoriesVisited: Int = 0
       @Published var savedPlaces: Int = 0
       @Published var visitedPlaces: Int = 0
       @Published var streaks: Int = 0
       @Published var mayorships: Int = 0
       @Published var photos: [String] = []  // Array of photo URLs
    
    init(user: User) {
        self.user = user
        fetchProfileData()
    }

    func fetchProfileData() {
        // Fetch user data from Firestore
        let db = Firestore.firestore()
        db.collection("users").document(user.id).getDocument { [weak self] (document, error) in
            guard let self = self, let document = document, document.exists else {
                print("Error fetching user data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let data = document.data() {
                self.user.username = data["username"] as? String ?? self.user.username
                self.user.bio = data["bio"] as? String ?? self.user.bio
                self.user.profilePictureURL = data["profilePictureURL"] as? String
                
                self.totalCheckIns = data["totalCheckIns"] as? Int ?? 0
                self.categoriesVisited = data["categoriesVisited"] as? Int ?? 0
                self.savedPlaces = data["savedPlaces"] as? Int ?? 0
                self.visitedPlaces = data["visitedPlaces"] as? Int ?? 0
                self.streaks = data["streaks"] as? Int ?? 0
                self.mayorships = data["mayorships"] as? Int ?? 0
                self.photos = data["photos"] as? [String] ?? []
            }
        }
    }

    func updateProfile(username: String, bio: String) {
        let db = Firestore.firestore()
        db.collection("users").document(user.id).updateData([
            "username": username,
            "bio": bio
        ]) { [weak self] error in
            if let error = error {
                print("Error updating profile: \(error.localizedDescription)")
            } else {
                self?.user.username = username
                self?.user.bio = bio
            }
        }
    }

    func checkIn(at place: String) {
        let db = Firestore.firestore()
        db.collection("users").document(user.id).updateData([
            "totalCheckIns": FieldValue.increment(Int64(1)),
            "visitedPlaces": FieldValue.increment(Int64(1))
        ]) { [weak self] error in
            if let error = error {
                print("Error updating check-in: \(error.localizedDescription)")
            } else {
                self?.totalCheckIns += 1
                self?.visitedPlaces += 1
            }
        }
        
        // Add check-in to user's history
        db.collection("users").document(user.id).collection("checkIns").addDocument(data: [
            "place": place,
            "timestamp": FieldValue.serverTimestamp()
        ])
    }
}
