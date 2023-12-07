//
//  MainTabView.swift
//  Instagram
//
//  Created by darktech4 on 07/12/2023.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
            
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            Text("Upload Post")
                .tabItem {
                    Image(systemName: "plus.square")
                }

            Text("Notification")
                .tabItem {
                    Image(systemName: "heart")
                }

           ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }

        }
        .accentColor(.text)
    }
}

#Preview {
    MainTabView()
}
