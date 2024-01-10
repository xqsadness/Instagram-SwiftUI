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
    
    static func fetchFeedPosts(completion: @escaping ([Post]) -> Void) {
        postsCollection.order(by: "timestamp", descending: true).addSnapshotListener { snapshot, _ in
            guard let snapshot = snapshot else {
                completion([])
                return
            }
            do{
                completion(try snapshot.documents.compactMap({ try $0.data(as: Post.self) }))
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post]{
        let snapshot = try await postsCollection.whereField("ownerID", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
}
