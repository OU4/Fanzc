import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FriendRequestService: ObservableObject {
    @Published var friendRequests = [FriendRequest]()

    private let firestore = Firestore.firestore()

    func sendFriendRequest(from senderID: String, to receiverID: String, completion: @escaping (Error?) -> Void) {
        let friendRequest = FriendRequest(id: UUID().uuidString, senderID: senderID, receiverID: receiverID, status: "pending")
        do {
            try firestore.collection("friendRequests").document(friendRequest.id).setData(from: friendRequest)
            fetchFriendRequests(forUser: senderID)
            completion(nil)
        } catch {
            completion(error)
        }
    }

    func respondToRequest(requestID: String, status: String, completion: @escaping (Error?) -> Void) {
        firestore.collection("friendRequests").document(requestID).updateData(["status": status]) { error in
            completion(error)
        }
    }

    func fetchFriendRequests(forUser userID: String) {
        firestore.collection("friendRequests").whereField("receiverID", isEqualTo: userID).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching friend requests: \(error)")
            } else {
                self.friendRequests = snapshot?.documents.compactMap { try? $0.data(as: FriendRequest.self) } ?? []
            }
        }
    }
}
