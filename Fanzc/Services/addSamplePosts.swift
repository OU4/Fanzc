//
//  addSamplePosts.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 26/09/2024.
//


// File: /Fanzc/Core/Services/PostService.swift (or similar path)

import Firebase
import FirebaseFirestoreSwift

class PostService: ObservableObject {
    @Published var posts: [Post] = []
    private var db = Firestore.firestore()

    // ... existing functions ...

    func addSamplePosts() {
        let samplePosts = [
            Post(authorID: "user1", authorName: "Alice", authorProfilePictureURL: "https://example.com/alice.jpg", content: "Hello, world!", timestamp: Date(), mediaURL: nil, likes: 0, comments: [], currentUserLiked: false),
            Post(authorID: "user2", authorName: "Bob", authorProfilePictureURL: "https://example.com/bob.jpg", content: "SwiftUI is awesome!", timestamp: Date(), mediaURL: nil, likes: 0, comments: [], currentUserLiked: false)
        ]
        
        for post in samplePosts {
            do {
                let _ = try db.collection("posts").addDocument(from: post)
                print("Successfully added sample post")
            } catch {
                print("Error adding sample post: \(error.localizedDescription)")
            }
        }
    }
}
