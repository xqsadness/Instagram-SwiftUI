//
//  FeedViewModel.swift
//  Instagram
//
//  Created by iamblue on 06/01/2024.
//

import Foundation
import Firebase


class FeedViewModel: ObservableObject{
    
    @Published var isLoading:Bool = true
    @Published var posts = [Post]()
    @Published var scrolledID: Post?
    
    init(){
        Task { try await fetchPosts() }
    }
    
    @MainActor
    func fetchPosts() async throws{
        self.posts = try await PostService.fetchFeedPosts()
        self.isLoading = false
    }
    
}
