//
//  CurrentUserProfileView.swift
//  Instagram
//
//  Created by iamblue on 08/12/2023.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    
    @State var isShowSetting = false
    @State var showChangeMode = true
    @State var showingLogout = false
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        ZStack(alignment: .top){
            VStack{
                HStack{
                    Text("\(user.username) ▽")
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
                
                ScrollView(showsIndicators: false){
                    // header
                    
                    ProfileHeaderView(user: user)
                    
                    // post grid view
                    PostGridView(user: user)
                }
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
    
    private var sheetMore: some View{
        VStack(spacing: 13){
            Capsule()
                .frame(width: 65, height: 6)
                .foregroundStyle(.gray).opacity(0.3)
            
            optionSetting(systemName: "gearshape", text: "Change Mode")
                .onTapGesture {
                    withAnimation {
                        isShowSetting = false
                        showChangeMode.toggle()
                    }
                }
            
            optionSetting(systemName: "doc.badge.gearshape", text: "Setting & privacy")
            
            optionSetting(systemName: "heart", text: "Favorite")
            
            optionSetting(systemName: "door.left.hand.open", text: "Logout", tint: .red)
                .onTapGesture {
                    showingLogout.toggle()
                }
                .alert(isPresented: $showingLogout) {
                    Alert(
                        title: Text("Confirm logout"),
                        message: Text("Are you sure want to sign out?"),
                        primaryButton: .default(
                            Text("Cancel"),
                            action: {}
                        ),
                        secondaryButton: .destructive(
                            Text("Logout"),
                            action: {
                                AuthService.shared.signout()
                            }
                        )
                    )
                }
        }
        .padding()
        .hAlign(.leading)
        .vAlign(.top)
        .presentationDetents([.height(UIScreen.main.bounds.height / 2.75)])
    }
    
    private func optionSetting(systemName: String, text: String, tint: Color = .text) -> some View{
        HStack{
            Image(systemName: systemName)
                .imageScale(.large)
                .foregroundStyle(tint)
            
            Text("\(text)")
                .font(.regular(size: 16))
                .foregroundStyle(tint)
        }
        .hAlign(.leading)
    }
}
