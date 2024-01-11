//
//  Comment.swift
//  Instagram
//
//  Created by iamblue on 11/01/2024.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Hashable, Codable{
    var id = NSUUID().uuidString
    var content: String
    var likes: Int
    var timestamp: Timestamp
    var user: User?
    
    var timestampString: String{
        return timestamp.dateValue().timestampString()
    }
}
