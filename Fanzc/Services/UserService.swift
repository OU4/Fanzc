//
//  UserService.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 26/09/2024.
//

// File: UserService.swift
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserService {
    private let firestore = Firestore.firestore()

    func fetchUser(byID userID: String) {
        firestore.collection("users").document(userID).getDocument { document, error in
            if let document = document, document.exists {
                do {
                    let user = try document.data(as: User.self) // Requires User to conform to Decodable
                    // Use the decoded user
                } catch {
                    print("Error decoding user: \(error)")
                }
            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "unknown")")
            }
        }
    }

    func saveUser(_ user: User) {
        do {
            try firestore.collection("users").document(user.id).setData(from: user) // Requires User to conform to Encodable
        } catch {
            print("Error encoding user: \(error)")
        }
    }
}
  
