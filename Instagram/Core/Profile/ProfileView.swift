//
//  ProfileView.swift
//  Instagram
//
//  Created by darktech4 on 07/12/2023.
//

import SwiftUI

struct ProfileView: View {
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                // header
                VStack(spacing: 10){
                    VStack {
                        // pic and stats.
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
                        
                        HStack {
                            
                        }
                        // name and bio
                        VStack(alignment: .leading, spacing: 4){
                            Text("Expensive melon")
                                .font(.semibold(size: 13))
                            
                            Text("Expensive melon")
                                .font(.regular(size: 12))
                        }
                        .hAlign(.leading)
                        .padding(.horizontal)
                        
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
                
                // post grid view
                LazyVGrid(columns: gridItems, spacing: 1){
                    ForEach(0...15, id: \.self){ index in
                        Image("avt-t2")
                            .resizable()
                            .scaledToFill()
                    }
                }
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        
                    }label:{
                     Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .foregroundStyle(.text)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
