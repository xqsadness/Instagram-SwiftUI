//
//  PostGridViewModel.swift
//  Instagram
//
//  Created by iamblue on 08/01/2024.
//

import Foundation

class PostGridViewModel: ObservableObject{
    
    private let user: User
    @Published var posts = [Post]()
    
    init(user: User){
        self.user = user
        
        Task{ try await fetchUserPost() }
    }
    
    @MainActor
    func fetchUserPost() async throws{
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
        
        for i in posts.indices{
            posts[i].user = self.user
        }
    }
}
