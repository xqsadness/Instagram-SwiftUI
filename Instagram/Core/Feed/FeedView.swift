//
//  FeedView.swift
//  Instagram
//
//  Created by darktech4 on 07/12/2023.
//

import SwiftUI

struct FeedView: View {
    @AppStorage("colorScheme") var colorScheme = "dark"
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 32){
                    ForEach(Post.MOCK_POSTS){ post in
                        FeedCell(post: post)
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(getColorScheme() == .dark ? .igLogoWhite : .igLogoBlack)
                        .resizable()
                        .frame(width: 110, height: 30)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            }
        }
    }
    
    func getColorScheme() -> ColorScheme?{
        if colorScheme == "dark"{
            return .dark
        }else if colorScheme == "light"{
            return .light
        }else{
            return nil
        }
    }
}

#Preview {
    FeedView()
}
