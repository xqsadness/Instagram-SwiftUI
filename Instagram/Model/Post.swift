//
//  Post.swift
//  Instagram
//
//  Created by iamblue on 11/12/2023.
//

import Foundation
import Firebase

struct Post: Identifiable, Hashable, Codable {
    let id: String
    var ownerID: String
    var caption: String
    var likes: Int
    var imageUrl: String
    var timestamp: Timestamp
    var user: User?
}

extension Post{
    static var MOCK_POSTS: [Post] = [
        .init(id: UUID().uuidString, ownerID: UUID().uuidString, caption: "This is test caption", likes: 225, imageUrl: "batman", timestamp: Timestamp(), user: User.MOCK_USERS[0]),
        .init(id: UUID().uuidString, ownerID: UUID().uuidString, caption: "Die for you, Joji", likes: 543, imageUrl: "the-flash", timestamp: Timestamp(), user: User.MOCK_USERS[2]),
        .init(id: UUID().uuidString, ownerID: UUID().uuidString, caption: "I love you in all universes", likes: 1000, imageUrl: "batman", timestamp: Timestamp(), user: User.MOCK_USERS[3]),
        .init(id: UUID().uuidString, ownerID: UUID().uuidString, caption: "Because i love you", likes: 233, imageUrl: "the-flash", timestamp: Timestamp(), user: User.MOCK_USERS[4]),
        .init(id: UUID().uuidString, ownerID: UUID().uuidString, caption: "Wow, so beautiful", likes: 964, imageUrl: "batman", timestamp: Timestamp(), user: User.MOCK_USERS[1])
    ]
}
