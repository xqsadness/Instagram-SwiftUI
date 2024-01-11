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
        
        // Retrieve the current data of the post
        var postData = try await postRef.getDocument().data(as: Post.self)
        
        // Create a new Comment object
        let newComment = Comment(content: content, likes: 0, timestamp: Timestamp(), user: currentUser)
        // Append the new Comment to the comments array of the post
        postData.comments.append(newComment)
        
        // Update the data of the post on Firestore
        try await postRef.updateData(Firestore.Encoder().encode(postData))
    }

    
}
