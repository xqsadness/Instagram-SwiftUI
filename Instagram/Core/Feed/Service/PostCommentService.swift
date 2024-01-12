//
//  PostCommentService.swift
//  Instagram
//
//  Created by iamblue on 11/01/2024.
//

import Foundation
import Firebase

struct PostCommentService{
    
    static func commentPost(postID: String, content: String) async throws {
        // Ensure the user is authenticated
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        
        // Fetch the current user
        let currentUser = try await UserService.fetchUser(withUid: currentUID)
        
        // Reference to the document of the post
        let postRef = Firestore.firestore().collection("posts").document(postID)
        
        // Create a new Comment object and Encoder
        let newComment = try Firestore.Encoder().encode(Comment(content: content, likes: 0, timestamp: Timestamp(), user: currentUser))
        
        // Use FieldValue.arrayUnion to add the new comment to the array
        try await postRef.updateData([
            "comments": FieldValue.arrayUnion([newComment])
        ])
    }
}
