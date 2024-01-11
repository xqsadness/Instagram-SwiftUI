//
//  PostComment.swift
//  Instagram
//
//  Created by iamblue on 10/01/2024.
//

import SwiftUI

fileprivate enum FocusedField {
    case content
}

struct PostComment: View {
    
    @StateObject var viewModel = PostCommentViewModel()
    @FocusState private var focusedField: FocusedField?

    let post: Post
    
    var body: some View {
        VStack{
            header
            
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(spacing: 17){
                    ForEach(post.comments){ comment in
                        ItemPostComment(comment: comment)
                    }
                }
            }
            
            textField
        }
        .onAppear{
            if !post.comments.isEmpty{
                focusedField = .content
            }
        }
    }
}

#Preview {
    PostComment(post: Post.MOCK_POSTS[0])
}

extension PostComment{
    
    private var header: some View{
        VStack{
            Text("Comments (\(post.comments.count))")
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
                
                TextField("Add a comment for \(user.username)", text: $viewModel.content)
                    .focused($focusedField, equals: .content)
                    .font(.medium(size: 14))
                    .submitLabel(.done)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(height: 33)
                            .foregroundStyle(.gray)
                            .padding(-4)
                    }
                    .onSubmit {
                        if viewModel.content.isEmpty{
                            focusedField = nil

                            Toast.shared.present(
                                title: "Content cannot be empty",
                                symbol: "",
                                isUserInteractionEnabled: true,
                                timing: .medium,
                                position: .bottom
                            )
                        }else{
                            Task{
                                try await viewModel.commentPost(postID: post.id)
                                focusedField = nil
                            }
                        }
                    }
            }
        }
        .hAlign(.leading)
        .padding(.horizontal,9)
    }
}
