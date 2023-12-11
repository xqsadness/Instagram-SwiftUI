//
//  CurrentUserProfileView.swift
//  Instagram
//
//  Created by darktech4 on 08/12/2023.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    
    @State var isShowSetting = false
    @State var showChangeMode = true
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    var posts: [Post] {
       return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false){
                // header
                HStack{
                    Text("iamblue_2801" + " ▽")
                        .foregroundStyle(.text)
                        .font(.semibold(size: 15))
                    Spacer()
                    Button{
                        withAnimation {
                            showChangeMode = true
                            isShowSetting.toggle()
                        }
                    }label:{
                        Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .foregroundStyle(.text)
                    }
                }
                .padding(.bottom)
                .padding(.horizontal)
                
                ProfileHeaderView(user: user)
                
                // post grid view
                PostGridView(posts: posts)
            }
            .sheet(isPresented: $isShowSetting, content: {
                sheetMore
            })
            .onDisappear{
                withAnimation {
                    showChangeMode = true
                }
            }
            
            DarkLightModeView(show: $showChangeMode)
                .opacity(showChangeMode ? 0 : 1)
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}

extension CurrentUserProfileView{
    private var nameAndBio: some View{
        VStack(alignment: .leading, spacing: 4){
            Text("Expensive melon")
                .font(.semibold(size: 13))
            
            Text("Expensive melon")
                .font(.regular(size: 12))
        }
        .hAlign(.leading)
        .padding(.horizontal)
    }

    private var pictureAndStats: some View{
        HStack{
            Image(.avtT)
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
    
    private var sheetMore: some View{
        VStack(spacing: 13){
            Capsule()
                .frame(width: 65, height: 6)
                .foregroundStyle(.gray).opacity(0.3)
            
            HStack{
                Image(systemName: "gearshape")
                    .imageScale(.large)
                    .foregroundStyle(.text)
                
                Text("Change Mode")
                    .font(.regular(size: 16))
                    .foregroundStyle(.text)
            }
            .hAlign(.leading)
            .onTapGesture {
                withAnimation {
                    isShowSetting = false
                    showChangeMode.toggle()
                }
            }
            
            HStack{
                Image(systemName: "doc.badge.gearshape")
                    .imageScale(.large)
                    .foregroundStyle(.text)
                
                Text("Setting & privacy")
                    .font(.regular(size: 16))
                    .foregroundStyle(.text)
            }
            .hAlign(.leading)
            
            HStack{
                Image(systemName: "heart")
                    .imageScale(.large)
                    .foregroundStyle(.text)
                
                Text("Favorite")
                    .font(.regular(size: 16))
                    .foregroundStyle(.text)
            }
            .hAlign(.leading)
        }
        .padding()
        .hAlign(.leading)
        .vAlign(.top)
        .presentationDetents([.height(UIScreen.main.bounds.height / 2.75)])
    }
}
