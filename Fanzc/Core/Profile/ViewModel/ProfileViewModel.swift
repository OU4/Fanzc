////
////  ProfileViewModel.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 25/09/2024.
////
//
//
//// File: /Fanzc/Core/Profile/ViewModel/ProfileViewModel.swift
//
//import Foundation
//
//class ProfileViewModel: ObservableObject {
//    @Published var posts: [Post] = []
//    
//    init() {
//        fetchPosts()
//    }
//    
//    func fetchPosts() {
//        // TODO: Replace with actual API call
//        posts = [
//            Post(author: "Khaled Ahmed", content: "Hello, Fanzc!", timestamp: Date(), imageURL: nil, reactions: []),
//            Post(author: "Khaled Ahmed", content: "Check out this view!", timestamp: Date().addingTimeInterval(-3600), imageURL: "https://picsum.photos/400/300", reactions: []),
//            Post(author: "Khaled Ahmed", content: "Just finished a great book!", timestamp: Date().addingTimeInterval(-7200), imageURL: nil, reactions: [.like, .love])
//        ]
//    }
//    
//    func toggleReaction(_ post: Post, _ reaction: Reaction) {
//        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
//        
//        if posts[index].reactions.contains(reaction) {
//            posts[index].reactions.removeAll { $0 == reaction }
//        } else {
//            posts[index].reactions.append(reaction)
//        }
//    }
//}
