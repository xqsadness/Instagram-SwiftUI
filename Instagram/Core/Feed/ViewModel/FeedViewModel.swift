//
//  FeedViewModel.swift
//  Instagram
//
//  Created by iamblue on 06/01/2024.
//

import Foundation
import Firebase

@Observable
class FeedViewModel{
    
    var posts = [Post]()
    
    init(){
        Task { try await fetchPosts() }
    }
    
    func fetchPosts() async throws{
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        self.posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0 ..< posts.count{
            let post = posts[i]
            let ownerID = post.ownerID
            let postUser = try await UserService.fetchUser(withUid: ownerID)
            posts[i].user = postUser
        }
    }
    
}
