//
//  PostImage.swift
//  Instagram
//
//  Created by iamblue on 10/01/2024.
//

import SwiftUI
import Kingfisher

struct Like{
    var id: UUID = .init()
    var tappedRect: CGPoint = .zero
    var animated: Bool = false
}

struct PostImage: View {
    
    @StateObject var viewModel: FeedCellViewModel
    
    @Binding var post: Post
    @State var likeCounter: [Like] = []
    
    var body: some View {
        VStack{
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .fade(duration: 1)
                .placeholder{
                    Image(.df)
                        .resizable()
                        .scaledToFill()
                }
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
                .overlay(alignment: .topLeading){
                    HeartAnimation(likeCounter: $likeCounter)
                }
            //double tap like animation
                .onTapGesture(count: 2) { pos in
                    Task {
                        doubleTapLike(pos: pos)
                        try await viewModel.doubleTapLikePosts(postId: post.id)
                    }
                }
        }
    }
    
    func doubleTapLike(pos: CGPoint){
        let id = UUID()
        likeCounter.append(.init(id: id, tappedRect: pos, animated: false))
        // animating like
        withAnimation(.snappy(duration: 1.2), completionCriteria: .logicallyComplete) {
            if let index = likeCounter.firstIndex(where: { $0.id == id}) {
                likeCounter[index].animated = true
            }
        } completion: {
            likeCounter.removeAll(where: { $0.id == id})
        }
    }
}

struct HeartAnimation: View {
    
    @Binding var likeCounter: [Like]
    var safeArea: EdgeInsets = .init()
    
    var body: some View {
        ZStack{
            ForEach(likeCounter, id: \.id){ like in
                Image(systemName: "suit.heart.fill")
                    .font(.system(size: 75))
                    .foregroundStyle(.red.gradient)
                    .frame(width: 100, height: 100)
                    .animation(.smooth, body: { view in
                        view
                            .scaleEffect(like.animated ? 1 : 1.8)
                            .rotationEffect(.init(degrees: like.animated ? 0 : .random(in: -30...30)))
                    })
                    .offset(x: like.tappedRect.x - 50, y: like.tappedRect.y - 50)
                /// let animation
                    .offset(y: like.animated ? -(like.tappedRect.y + safeArea.top) : 0 )
            }
        }
    }
}
