//
//  FeedCellViewModel.swift
//  Instagram
//
//  Created by iamblue on 09/01/2024.
//

import Foundation
import Firebase

@MainActor
class FeedCellViewModel: ObservableObject{
    
    @Published var likePostIds: [String] = []
    
    init(){
        Task{ try await fetchLikePostIds() }
    }
    
    func likePosts(postId: String) async throws{
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let currentLikePostIds = try await UserService.fetchUser(withUid: currentUID).likedPostIDs
        
        if let index = currentLikePostIds.firstIndex(where: { $0 == postId }){
            likePostIds.remove(at: index)
            try await FeedService.likePosts(withUID: postId, isLike: false)
        }else{
            likePostIds.append(postId)
            try await FeedService.likePosts(withUID: postId, isLike: true)
        }
        
        try await FeedService.updateLikePostIDs(postID: postId)
    }
    
    func fetchLikePostIds() async throws {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        self.likePostIds = try await UserService.fetchUser(withUid: currentUID).likedPostIDs
    }
}
