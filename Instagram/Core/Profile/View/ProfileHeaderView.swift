//
//  ProfileHeaderView.swift
//  Instagram
//
//  Created by iamblue on 11/12/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    
    @State private var showEditProfile = false
        
    var body: some View {
        VStack(spacing: 10){
            VStack {
                // pic and stats.
                pictureAndStats
                
                // name and bio
                nameAndBio
                
                // action button
               actionBtn
            }
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}

extension ProfileHeaderView{
    
    private var actionBtn: some View{
        HStack{
            Button {
                if user.isCurrentUser{
                    showEditProfile.toggle()
                }else{
                    print("Follow user")
                }
            } label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .hAlign(.center)
                    .frame(height: 32)
                    .background(user.isCurrentUser ? .text2 : Color(.systemBlue))
                    .foregroundColor(user.isCurrentUser ? .text : .white)
                    .cornerRadius(5)
            }
            
            Button {
                Alerter.shared.alert = Alert(title: Text("This feature is being updated in the future"), dismissButton: .default(Text("OK")))
            } label: {
                Text(user.isCurrentUser ? "Share profile" : "Message")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .hAlign(.center)
                    .frame(height: 32)
                    .background(.text2)
                    .foregroundColor(.text)
                    .cornerRadius(5)
            }
        }
        .hAlign(.center)
        .padding(.horizontal,9)
    }
    
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
        .padding(.bottom,1)
        .padding(.horizontal,9)
    }
    
    private var pictureAndStats: some View{
        HStack{
            CircularProfileImageView(user: user, size: .large)
            
            Spacer()
            
            HStack(spacing: 17){
                UserStatView(value: 3, title: "Posts")
                
                UserStatView(value: 12, title: "Follower")
                
                UserStatView(value: 25, title: "Following")
            }
        }
        .padding(.horizontal,9)
        .padding(.bottom,3)
    }
    
}
