//
//  PostCommentViewModel.swift
//  Instagram
//
//  Created by iamblue on 11/01/2024.
//

import Foundation

@MainActor
class PostCommentViewModel: ObservableObject{
    
    @Published var content = ""
    
    func commentPost(postID: String) async throws {
        try await PostCommentService.commentPost(postID: postID, content: content)
        Toast.shared.present(
            title: "Comment successful",
            symbol: "",
            isUserInteractionEnabled: true,
            timing: .long,
            position: .bottom
        )
        
        self.content = ""
    }
}
