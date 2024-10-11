//
//  FriendRequest.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 26/09/2024.
//

import Foundation

struct FriendRequest: Codable, Identifiable {
    var id: String
    var senderID: String
    var receiverID: String
    var status: String // "pending", "accepted", "declined"
}
