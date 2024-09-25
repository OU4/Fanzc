////
////  FriendsView.swift
////  Fanzc
////
////  Created by Abdulaziz dot on 25/09/2024.
////
//
//
//// File: /Users/abdulazizdot/Desktop/Fanzc/Fanzc/Views/FriendsView.swift
//
//import SwiftUI
//
//struct FriendsView: View {
//    @State private var friends: [Friend] = []
//    
//    var body: some View {
//        NavigationView {
//            List(friends) { friend in
//                FriendRow(friend: friend)
//            }
//            .navigationTitle("Friends")
//            .onAppear {
//                loadFriends()
//            }
//        }
//    }
//    
//    private func loadFriends() {
//        // TODO: Implement friend loading logic
//        // This is just sample data
//        friends = [
//            Friend(id: UUID(), name: "John Doe", username: "@johndoe"),
//            Friend(id: UUID(), name: "Jane Smith", username: "@janesmith"),
//            Friend(id: UUID(), name: "Alice Johnson", username: "@alicej")
//        ]
//    }
//}
//
//struct Friend: Identifiable {
//    let id: UUID
//    let name: String
//    let username: String
//}
//
//struct FriendRow: View {
//    let friend: Friend
//    
//    var body: some View {
//        HStack {
//            ProfileImageView()
//                .frame(width: 50, height: 50)
//            VStack(alignment: .leading) {
//                Text(friend.name)
//                    .font(.headline)
//                Text(friend.username)
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//            }
//        }
//    }
//}
//
//struct FriendsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendsView()
//    }
//}
