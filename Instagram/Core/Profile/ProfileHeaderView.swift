//
//  ProfileHeaderView.swift
//  Instagram
//
//  Created by iamblue on 11/12/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 10){
            VStack {
                // pic and stats.
                pictureAndStats
                
                // name and bio
                nameAndBio
                
                // action button
                Button {
                    
                } label: {
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 32)
                        .foregroundColor(.text)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke (Color.gray, lineWidth: 1)
                        )
                }
                Divider()
            }
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}

extension ProfileHeaderView{
    private var nameAndBio: some View{
        VStack(alignment: .leading, spacing: 4){
            if let fullname = user.fullname{
                Text("\(fullname)")
                    .font(.semibold(size: 13))
            }
            if let bio = user.bio{
                Text("\(bio)")
                    .font(.regular(size: 12))
            }
        }
        .hAlign(.leading)
        .padding(.horizontal)
    }
    
    private var pictureAndStats: some View{
        HStack{
            Image(user.profileImageUrl ?? "")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            Spacer()
            
            HStack(spacing: 8){
                UserStatView(value: 3, title: "Posts")
                
                UserStatView(value: 12, title: "Follower")
                
                UserStatView(value: 25, title: "Following")
            }
        }
        .padding(.horizontal)
        .padding(.bottom,4)
    }
    
}
