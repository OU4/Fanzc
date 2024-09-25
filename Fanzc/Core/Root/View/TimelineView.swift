////
////  TimelineView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 25/09/2024.
////
//
//
//// File: /Fanzc/Views/TimelineView.swift
//
//import SwiftUI
//
//struct TimelineView: View {
//    @State private var posts: [Post] = []
//    @State private var isRefreshing = false
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
//                    await refreshPosts()
//                }
//                
//                LazyVStack(spacing: 16) {
//                    ForEach(posts) { post in
//                        PostView(post: post)
//                    }
//                }
//                .padding()
//            }
//            .coordinateSpace(name: "pullToRefresh")
//            .navigationTitle("Timeline")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//        .onAppear {
//            loadPosts()
//        }
//    }
//    
//    private func loadPosts() {
//        // TODO: Implement post loading from your backend
//        // This is a placeholder
//        posts = [
//            Post(id: UUID(), author: "John Doe", content: "Hello, Path!", timestamp: Date()),
//            Post(id: UUID(), author: "Jane Smith", content: "Loving this app!", timestamp: Date())
//        ]
//    }
//    
//    private func refreshPosts() async {
//        isRefreshing = true
//        // TODO: Implement actual refresh logic
//        await Task.sleep(1_000_000_000) // Simulate network delay
//        loadPosts()
//        isRefreshing = false
//    }
//}
//
//struct TimelineView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimelineView()
//    }
//}
//
//// Placeholder Post model
//struct Post: Identifiable {
//    let id: UUID
//    let author: String
//    let content: String
//    let timestamp: Date
//}
//
//// Custom PullToRefresh View
//struct PullToRefresh: View {
//    var coordinateSpaceName: String
//    var onRefresh: () async -> Void
//    
//    @State private var needRefresh: Bool = false
//    
//    var body: some View {
//        GeometryReader { geo in
//            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
//                Spacer()
//                    .onAppear {
//                        needRefresh = true
//                    }
//            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
//                Spacer()
//                    .onAppear {
//                        if needRefresh {
//                            needRefresh = false
//                            Task {
//                                await onRefresh()
//                            }
//                        }
//                    }
//            }
//            HStack {
//                Spacer()
//                if needRefresh {
//                    ProgressView()
//                } else {
//                    Text("⬇️")
//                }
//                Spacer()
//            }
//        }.padding(.top, -50)
//    }
//}
