import Foundation
import FirebaseFirestoreSwift


struct Post: Codable, Identifiable {
    @DocumentID var id: String?
    let authorID: String
    let authorName: String
    let authorProfilePictureURL: String
    let content: String
    let timestamp: Date
    let mediaURL: String?
    var likes: Int
    var comments: [Comment]
    var currentUserLiked: Bool
    let locationName: String?
    let locationDetails: String?

    enum CodingKeys: String, CodingKey {
        case id
        case authorID
        case authorName
        case authorProfilePictureURL
        case content
        case timestamp
        case mediaURL
        case likes
        case comments
        case currentUserLiked
        case locationName
        case locationDetails
    }
}

struct Comment: Codable, Identifiable {
    let id: String
    let authorID: String
    let authorName: String
    let content: String
    let timestamp: Date
    let locationName: String
    let locationDetails: String
    let checkInType: String
}



