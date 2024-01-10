//
//  FeedCell.swift
//  Instagram
//
//  Created by iamblue on 07/12/2023.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    @StateObject var viewModel = FeedCellViewModel()
    let post: Post
    
    var body: some View {
        VStack{
            //image + username
            HStack{
                if let user = post.user{
                    CircularProfileImageView(user: user, size: .xSmall)
                    
                    Text("\(user.username)")
                        .font(.semibold(size: 13))
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            
            //post image
            PostImage(viewModel: viewModel,post: .constant(post))
            
            //action btn
            HStack(spacing: 16){
                Button{
                    Task{ try await viewModel.likePosts(postId: post.id) }
                }label: {
                    Image(systemName: viewModel.likePostIds.contains(where: { $0 == post.id }) ? "heart.fill" : "heart")
                        .foregroundStyle(viewModel.likePostIds.contains(where: { $0 == post.id }) ? .red : .text)
                        .imageScale(.large)
                        .symbolEffect(.bounce, options: .default, value: viewModel.likePostIds.contains(where: { $0 == post.id }))
                }
                
                Button{
                    print("Comment on post")
                }label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                Button{
                    print("Share post")
                }label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundStyle(.text)
            
            //like label
            Text("\(post.likes) likes")
                .font(.semibold(size: 13))
                .hAlign(.leading)
                .padding(.leading,10)
                .padding(.top, 1)
            
            //caption label
            HStack{
                Text("\(post.user?.username ?? "") ").font(.semibold(size: 13)) +
                Text("\(post.caption)")
            }
            .hAlign(.leading)
            .font(.regular(size: 13))
            .padding(.leading,10)
            .padding(.top, 1)
            
            Text("\(post.timestampString)")
                .font(.regular(size: 13))
                .hAlign(.leading)
                .padding(.leading,10)
                .padding(.top, 1)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_POSTS[0])
}

