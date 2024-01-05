//
//  ProfileView.swift
//  Instagram
//
//  Created by iamblue on 07/12/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    let user: User
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
        VStack{
            titlePage
            
            ScrollView(showsIndicators: false){
                
                // header
                ProfileHeaderView(user: user)
                
                // post grid view
                PostGridView(posts: posts)
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[1])
}

extension ProfileView{
    
    private var titlePage: some View{
        HStack{
            Image(systemName: "chevron.left")
                .imageScale(.large)
                .foregroundStyle(.text)
            Text("Explore")
                .foregroundStyle(.text)
                .font(.semibold(size: 17))
        }
        .hAlign(.leading)
        .padding(.horizontal)
        .overlay{
            Text("\(user.username)")
                .foregroundStyle(.text)
                .font(.semibold(size: 17))
        }
        .padding(.bottom)
        .onTapGesture {
            coordinator.pop()
        }
    }
}
