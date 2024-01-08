//
//  PostService.swift
//  Instagram
//
//  Created by iamblue on 08/01/2024.
//

import Foundation
import Firebase

struct PostService{
    private static let postsCollection = Firestore.firestore().collection("posts")
    static func fetchFeedPosts() async throws -> [Post]{
        let snapshot = try await postsCollection.order(by: "timestamp", descending: true)
            .getDocuments()
        
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0 ..< posts.count{
            let post = posts[i]
            let ownerID = post.ownerID
            let postUser = try await UserService.fetchUser(withUid: ownerID)
            posts[i].user = postUser
        }
        return posts
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post]{
        let snapshot = try await postsCollection.whereField("ownerID", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
}
