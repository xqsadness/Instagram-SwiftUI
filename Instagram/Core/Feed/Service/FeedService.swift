//
//  FeedService.swift
//  Instagram
//
//  Created by iamblue on 09/01/2024.
//

import Foundation
import Firebase

struct FeedService{
    
    static func updateLikePostIDs(postID: String) async throws {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        
        let currentUser = try await UserService.fetchUser(withUid: currentUID)
        
        let userDocRef = Firestore.firestore().collection("users").document(currentUID)
        
        let updatedData = [
            "likedPostIDs": (currentUser.likedPostIDs.firstIndex(where: { $0 == postID }) != nil) ? FieldValue.arrayRemove([postID]) : FieldValue.arrayUnion([postID])
        ]
        
        try await userDocRef.updateData(updatedData)
    }
    
    static func likePosts(withUID: String, isLike: Bool) async throws{
        let postRef = Firestore.firestore().collection("posts").document(withUID)
        
        let currentLikePost = try await Firestore.firestore().collection("posts")
            .document(withUID)
            .getDocument()
            .data(as: Post.self).likes
        
        let updatedData = [
            "likes": currentLikePost >= 0 ? isLike ? currentLikePost + 1 : currentLikePost - 1 : 0
        ]
        
        try await postRef.updateData(updatedData)
    }
    
}
