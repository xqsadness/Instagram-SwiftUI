//
//  PostGridView.swift
//  Instagram
//
//  Created by darktech4 on 11/12/2023.
//

import SwiftUI

struct PostGridView: View {
    var posts: [Post]
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1){
            ForEach(posts){ post in
                Image(post.imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostGridView(posts: Post.MOCK_POSTS)
}
