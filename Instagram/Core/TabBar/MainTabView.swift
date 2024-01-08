//
//  MainTabView.swift
//  Instagram
//
//  Created by iamblue on 07/12/2023.
//

import SwiftUI
import Kingfisher

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    
    //So that FeedView does not reload when selected
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        VStack{
            switch selectedIndex{
            case 0:
                FeedView(viewModel: viewModel)
            case 1:
                SearchView()
            case 2:
                UploadPostView(tabIndex: $selectedIndex){
                    Task { try await viewModel.fetchPosts() }
                }
            case 3:
                Text("Reels")
                    .vAlign(.center)
            case 4:
                CurrentUserProfileView(user: user)
            default:
                EmptyView()
            }
            
            customTabUI
        }
    }
}

#Preview {
    MainTabView(user: User.MOCK_USERS[0])
}

extension MainTabView{
    
    private var customTabUI: some View{
        HStack(spacing: 50){
            Image(systemName: "house.fill")
                .imageScale(.large)
                .foregroundStyle(selectedIndex == 0 ? .text : .gray)
                .onTapGesture {
                    withAnimation {
                        selectedIndex = 0
                    }
                }
            
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
                .foregroundStyle(selectedIndex == 1 ? .text : .gray)
                .onTapGesture {
                    withAnimation {
                        selectedIndex = 1
                    }
                }
            
            Image(systemName:  "plus.square")
                .imageScale(.large)
                .foregroundStyle(selectedIndex == 2 ? .text : .gray)
                .onTapGesture {
                    withAnimation {
                        selectedIndex = 2
                    }
                }
            
            Image(systemName: "ipad.badge.play")
                .imageScale(.large)
                .foregroundStyle(selectedIndex == 3 ? .text : .gray)
                .onTapGesture {
                    withAnimation {
                        selectedIndex = 3
                    }
                }
            
            VStack{
                if let profileImageUrl = AuthService.shared.currentUser?.profileImageUrl{
                    KFImage(URL(string: profileImageUrl))
                        .resizable()
                        .fade(duration: 1)
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .placeholder{
                            Image(.avtT)
                                .resizable()
                                .scaledToFill()
                        }
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }else{
                    Image(.avtT)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .onTapGesture {
                withAnimation {
                    selectedIndex = 4
                }
            }
        }
        .hAlign(.center)
    }
}
