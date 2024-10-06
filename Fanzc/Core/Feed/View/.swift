////
////  PostView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 26/09/2024.
////
//
//import SwiftUI
//import SDWebImageSwiftUI
//
//struct PostView: View {
//    var post: Post
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(post.content)
//                .font(.subheadline)
//            if let mediaURL = post.mediaURL, !mediaURL.isEmpty {
//                WebImage(url: URL(string: mediaURL))
//                    .resizable()
//                    .scaledToFit()
//            }
//            HStack {
//                Button(action: {
//                    // Handle like action
//                }) {
//                    Image(systemName: "heart")
//                }
//                Text("\(post.likes) likes")
//            }
//        }
//        .padding()
//    }
//}
//
//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(post: Post(id: "1", authorID: "user1", content: "Hello World", timestamp: Date(), mediaURL: "", likes: 5))
//    }
//}
