//// File: /Fanzc/Core/Root/ViewModel/TimelineViewModel.swift
//
//import Foundation
//import SwiftUI
//
//class TimelineViewModel: ObservableObject {
//    @Published var posts: [Post] = []
//    
//    func fetchPosts() async {
//        // Simulate network delay
//        try? await Task.sleep(nanoseconds: 1_000_000_000)
//        
//        // TODO: Replace with actual API call
//        let newPosts = [
//            Post(id: UUID(), author: "John Doe", content: "Hello, Path!", timestamp: Date(), imageURL: nil, reactions: []),
//            Post(id: UUID(), author: "Jane Smith", content: "Check out this view!", timestamp: Date().addingTimeInterval(-3600), imageURL: "https://picsum.photos/400/300", reactions: []),
//            Post(id: UUID(), author: "Alice Johnson", content: "Just finished a great book!", timestamp: Date().addingTimeInterval(-7200), imageURL: nil, reactions: [.like, .love])
//        ]
//        
//        DispatchQueue.main.async {
//            self.posts = newPosts
//        }
//    }
//    
//    func addPost(_ post: Post) {
//        posts.insert(post, at: 0)
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
