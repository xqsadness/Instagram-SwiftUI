//
//  ItemPostComment.swift
//  Instagram
//
//  Created by iamblue on 11/01/2024.
//

import SwiftUI

struct ItemPostComment: View {
    
    let comment: Comment
    
    var body: some View {
        HStack(alignment: .top){
            if let user = comment.user{
                CircularProfileImageView(user: user, size: .xSmall)
                
                VStack(alignment: .leading, spacing: 5){
                    HStack(spacing: 6){
                        Text("\(user.username)")
                            .font(.medium(size: 13))
                            .foregroundStyle(.text)
                        
                        Text("\(comment.timestampString)")
                            .font(.regular(size: 12))
                            .foregroundStyle(.gray)
                    }
                    
                    Text("\(comment.content)")
                        .font(.medium(size: 14))
                        .foregroundStyle(.text)
                    
                    Button{
                        Alerter.shared.alert = Alert(title: Text("This feature is being updated in the future"), dismissButton: .default(Text("OK")))
                    }label: {
                        Text("Reply")
                            .font(.medium(size: 13))
                            .foregroundStyle(.gray)
                    }
                }
                .hAlign(.leading)
            }
        }
        .padding(.horizontal,9)
    }
}
