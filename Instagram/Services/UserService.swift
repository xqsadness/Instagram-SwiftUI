//
//  UserService.swift
//  Instagram
//
//  Created by iamblue on 05/01/2024.
//

import Foundation
import Firebase

struct UserService{
    
    static func fetchUser(withUid: String) async throws -> User{
        let snapshot = try await Firestore.firestore().collection("users").document(withUid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchAllUser() async throws -> [User]{
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
}
