//
//  PostComment.swift
//  Instagram
//
//  Created by iamblue on 10/01/2024.
//

import SwiftUI

struct PostComment: View {
    
    @State var commentText = ""
    let post: Post
    
    var body: some View {
        VStack{
            header

            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(spacing: 17){
                    ForEach(0..<10){ _ in
                        HStack(alignment: .top){
                            if let user = post.user{
                                CircularProfileImageView(user: user, size: .xSmall)
                            }
                            
                            VStack(alignment: .leading, spacing: 5){
                                HStack(spacing: 6){
                                    Text("user name")
                                        .font(.medium(size: 14))
                                        .foregroundStyle(.text)
                                    
                                    Text("4d")
                                        .font(.regular(size: 13))
                                        .foregroundStyle(.gray)
                                }
                                
                                Text("user name")
                                    .font(.medium(size: 14))
                                    .foregroundStyle(.text)
                                
                                Text("Reply")
                                    .font(.medium(size: 13))
                                    .foregroundStyle(.gray)
                            }
                            .hAlign(.leading)
                        }
                        .padding(.horizontal,9)
                    }
                }
            }
            
            textField
        }
    }
}

#Preview {
    PostComment(post: Post.MOCK_POSTS[0])
}

extension PostComment{
    
    private var header: some View{
        VStack{
            Text("Comments")
                .font(.semibold(size: 15))
                .foregroundStyle(.text)
            
            Divider()
        }
        .padding(.top,25)
    }
    
    private var textField: some View{
        HStack{
            if let user = post.user{
                CircularProfileImageView(user: user, size: .xSmall)
                
                TextField("Add a comment for \(user.username)", text: $commentText)
                    .font(.medium(size: 14))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(height: 33)
                            .foregroundStyle(.gray)
                            .padding(-4)
                    }
            }
        }
        .hAlign(.leading)
        .padding(.horizontal,9)
    }
}
