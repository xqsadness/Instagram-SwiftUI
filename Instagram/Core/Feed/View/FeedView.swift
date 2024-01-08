//
//  FeedView.swift
//  Instagram
//
//  Created by iamblue on 07/12/2023.
//

import SwiftUI

struct FeedView: View {
    @AppStorage("colorScheme") var colorScheme = "dark"
    
    var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                if viewModel.isLoading{
                    loadDataShimmering
                }else{
                    if viewModel.posts.isEmpty{
                        Text("You don't have any post!")
                            .padding(.top,20)
                            .font(.regular(size: 15))
                            .foregroundStyle(.text).opacity(0.6)
                    }else{
                        LazyVStack(spacing: 32){
                            ForEach(viewModel.posts){ post in
                                FeedCell(post: post)
                            }
                        }
                        .padding(.top, 8)
                    }
                }
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
            .refreshable {
                Task{ try await viewModel.fetchPosts() }
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

extension FeedView{
    
    private var loadDataShimmering: some View{
        VStack{
            ForEach(0..<2){ _ in
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.text).opacity(0.7)
                    .hAlign(.leading)
                    .padding(.leading, 8)
                
                Rectangle()
                    .foregroundColor(.text).opacity(0.6)
                    .cornerRadius(13)
                    .frame(height: 400)
                
                Rectangle()
                    .foregroundColor(.text).opacity(0.6)
                    .cornerRadius(13)
                    .frame(width: 130, height: 10)
                    .hAlign(.leading)
                    .padding(.leading, 8)
                
                Rectangle()
                    .foregroundColor(.text).opacity(0.6)
                    .cornerRadius(13)
                    .frame(width: 100, height: 10)
                    .hAlign(.leading)
                    .padding(.leading, 8)
                
                Rectangle()
                    .foregroundColor(.text).opacity(0.6)
                    .cornerRadius(13)
                    .frame(width: 50, height: 10)
                    .hAlign(.leading)
                    .padding(.leading, 8)
                    .padding(.bottom, 22)
            }
        }
        .shimmering(bandSize: 1)
    }
}
