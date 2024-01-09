//
//  FeedService.swift
//  Instagram
//
//  Created by darktech4 on 09/01/2024.
//

import Foundation
import Firebase

struct FeedService{
    
    static func updateLikePostIDs(postID: String) async throws {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        
        let currentUser = try await UserService.fetchUser(withUid: currentUID)
        
        let userDocRef = Firestore.firestore().collection("users").document(currentUID)
        
        var updatedData = [
            "likedPostIDs": (currentUser.likedPostIDs.firstIndex(where: { $0 == postID }) != nil) ? FieldValue.arrayRemove([postID]) : FieldValue.arrayUnion([postID])
        ]

        try await userDocRef.updateData(updatedData)
    }
    
}
