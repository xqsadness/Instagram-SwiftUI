//
//  User.swift
//  Instagram
//
//  Created by iamblue on 08/12/2023.
//

import Foundation
import Firebase

struct User: Identifiable,Hashable ,Codable{
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var likedPostIDs: [String] = []
    var followerIDs: [String] = []
    var followingIDs: [String] = []
    
    var isCurrentUser: Bool{
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User{
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "batman",profileImageUrl: "batman",fullname: "Bruce wayne",bio: "Gotham dark night" ,email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "theflash",profileImageUrl: "the-flash",fullname: "berry",bio: "Gotham dark night" ,email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "spiderMan",profileImageUrl: "batman",fullname: "peter",bio: "Gotham dark night" ,email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "venom",profileImageUrl: "batman",fullname: "Jame",bio: "Gotham dark night" ,email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "ironman",profileImageUrl: "batman",fullname: "tony",bio: "Gotham dark night" ,email: "batman@gmail.com"),
    ]
}
