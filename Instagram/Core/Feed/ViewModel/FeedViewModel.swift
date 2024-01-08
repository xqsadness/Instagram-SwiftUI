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
    
    var isLoading:Bool = true
    var posts = [Post]()
    
    init(){
        Task { try await fetchPosts() }
    }
    
    func fetchPosts() async throws{
        self.posts = try await PostService.fetchFeedPosts()
        self.isLoading = false
    }
    
}
