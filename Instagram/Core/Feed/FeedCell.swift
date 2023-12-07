//
//  FeedCell.swift
//  Instagram
//
//  Created by darktech4 on 07/12/2023.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack{
            //image + username
            HStack{
                Image("batman")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text("Batman")
                    .font(.semibold(size: 13))
                
                Spacer()
            }
            .padding(.leading, 8)
            
            //post image
            Image("the-flash")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            //action btn
            HStack(spacing: 16){
                Button{
                    print("Like post")
                }label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
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
            Text("2003 likes")
                .font(.semibold(size: 13))
                .hAlign(.leading)
                .padding(.leading,10)
                .padding(.top, 1)
            
            //caption label
            HStack{
                Text("BATMAN ").font(.semibold(size: 13)) +
                Text("This is some test caption for now this is some the test caption ")
            }
            .hAlign(.leading)
            .font(.regular(size: 13))
            .padding(.leading,10)
            .padding(.top, 1)
            
            Text("2h ago")
                .font(.regular(size: 13))
                .hAlign(.leading)
                .padding(.leading,10)
                .padding(.top, 1)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    FeedCell()
}
