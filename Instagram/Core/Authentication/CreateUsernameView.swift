//
//  CreateUsernameView.swift
//  Instagram
//
//  Created by darktech4 on 08/12/2023.
//

import SwiftUI

struct CreateUsernameView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var username: String = ""
    
    var body: some View {
        VStack(spacing: 12){
            Image(systemName: "chevron.left")
                .imageScale(.large)
                .padding(.horizontal)
                .foregroundStyle(.text)
                .hAlign(.leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.pop()
                }
            
            Text("Add your username")
                .font(.bold(size: 20))
                .padding(.top)
            
            Text("You'll use this username to sign in to your account ")
                .font(.regular(size: 14))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 24)
            
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
            
            Button{
                coordinator.push(.createPasswordView)
            }label: {
                Text("Next")
                    .font(.semibold(size: 13))
                    .foregroundStyle(.text2)
                    .frame(width: 360, height: 44)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
        }
    }
}

#Preview {
    CreateUsernameView()
}
