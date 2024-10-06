////
////  PostView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 25/09/2024.
////
//
//
//// File: /Fanzc/Views/PostView.swift
//
//import SwiftUI
//
//struct PostView: View {
//    let post: Post
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            HStack {
//                ProfileImageView()
//                
//                VStack(alignment: .leading) {
//                    Text(post.author)
//                        .font(.headline)
//                    Text(post.timestamp, style: .relative)
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    // TODO: Implement more options menu
//                }) {
//                    Image(systemName: "ellipsis")
//                        .foregroundColor(.gray)
//                }
//            }
//            
//            Text(post.content)
//                .font(.body)
//            
//            HStack {
//                Button(action: {
//                    // TODO: Implement like functionality
//                }) {
//                    Image(systemName: "heart")
//                        .foregroundColor(.gray)
//                }
//                
//                Button(action: {
//                    // TODO: Implement comment functionality
//                }) {
//                    Image(systemName: "bubble.right")
//                        .foregroundColor(.gray)
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    // TODO: Implement share functionality
//                }) {
//                    Image(systemName: "square.and.arrow.up")
//                        .foregroundColor(.gray)
//                }
//            }
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
//    }
//}
//
//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(post: Post(id: UUID(), author: "John Doe", content: "This is a sample post", timestamp: Date()))
//    }
//}
