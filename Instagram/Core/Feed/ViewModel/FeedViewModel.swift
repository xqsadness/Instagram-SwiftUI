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
        PostService.fetchFeedPosts { posts in
            Task{
                for post in posts{
                    // Check if the post is already in the 'posts' array
                    if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
                        // If found, update the likes for the existing post
                        self.posts[index].likes = post.likes
                    }else{
                        self.posts = posts
                        
                        if !self.posts.isEmpty{
                            for i in self.posts.indices{
                                let post = self.posts[i]
                                let ownerID = post.ownerID
                                let postUser = try await UserService.fetchUser(withUid: ownerID)
                                self.posts[i].user = postUser
                            }
                        }
                        self.isLoading = false
                    }
                }
            }
            if posts.isEmpty{
                self.isLoading = false
            }
        }
    }
    
}
