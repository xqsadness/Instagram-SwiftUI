//
//  FeedView.swift
//  Instagram
//
//  Created by iamblue on 07/12/2023.
//

import SwiftUI

struct FeedView: View {
    @AppStorage("colorScheme") var colorScheme = "dark"
    
    @StateObject var viewModel: FeedViewModel
    
    var body: some View {
        VStack{
            toolbar
            
            ScrollView(showsIndicators: false){
                StoryView()
                
                if viewModel.isLoading{
                    loadDataShimmering
                }else{
                    if viewModel.posts.isEmpty{
                        Text("You don't have any post!")
                            .padding(.top,20)
                            .font(.regular(size: 15))
                            .foregroundStyle(.text).opacity(0.6)
                    }else{
                        LazyVStack(spacing: 29){
                            ForEach(viewModel.posts){ post in
                                FeedCell(post: post)
                            }
                        }
                        .padding(.top, 8)
                        .scrollTargetLayout()
                    }
                }
            }
            .scrollPosition(id: .constant(viewModel.scrolledID?.id), anchor: .top)
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
    FeedView( viewModel: .init())
}

extension FeedView{
    
    private var toolbar: some View{
        HStack{
            Image(getColorScheme() == .dark ? .igLogoWhite : .igLogoBlack)
                .resizable()
                .frame(width: 110, height: 30)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        viewModel.scrolledID = viewModel.posts.first
                    }
                }
            
            Spacer()
            
            Image(systemName: "heart")
                .foregroundStyle(.text)
                .imageScale(.large)
                .padding(.trailing,5)
                .onTapGesture {
                    Alerter.shared.alert = Alert(title: Text("This feature is being updated in the future"), dismissButton: .default(Text("OK")))
                }
            
            Image(systemName: "message")
                .foregroundStyle(.text)
                .imageScale(.large)
                .onTapGesture {
                    Alerter.shared.alert = Alert(title: Text("This feature is being updated in the future"), dismissButton: .default(Text("OK")))
                }
        }
        .padding(.horizontal)
    }
    
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
