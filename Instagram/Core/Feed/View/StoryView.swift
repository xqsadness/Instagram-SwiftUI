//
//  StoryView.swift
//  Instagram
//
//  Created by iamblue on 10/01/2024.
//

import SwiftUI
import Firebase
import Kingfisher

struct StoryView: View {
    var body: some View {
        HStack{
            ScrollView(.horizontal, showsIndicators: false){
                VStack{
                    VStack{
                        if let user = AuthService.shared.currentUser{
                            CircularProfileImageView(user: user, size: .medium)
                        }else{
                            Image(.avtT)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .scaledToFill()
                                .clipShape(Circle())
                        }
                    }
                    .overlay(alignment: .bottomTrailing){
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 21, height: 21)
                            .foregroundStyle(.text)
                    }
                    
                    Text("Your story")
                        .font(.regular(size: 13))
                        .foregroundStyle(.text)
                        .padding(.top,1)
                }
                .padding(.horizontal,9)
                .onTapGesture {
                    Alerter.shared.alert = Alert(title: Text("This feature is being updated in the future"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

#Preview {
    StoryView()
}
