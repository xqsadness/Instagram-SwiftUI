//
//  CreatePasswordView.swift
//  Instagram
//
//  Created by darktech4 on 08/12/2023.
//

import SwiftUI

struct CreatePasswordView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var password: String = ""
    
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
            
            Text("Create a password")
                .font(.bold(size: 20))
                .padding(.top)
            
            Text("You password must be at least 6 character in length ")
                .font(.regular(size: 14))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 24)
            
            SecureField("Password", text: $password)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            Button{
                coordinator.push(.completeSignUpView)
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
    CreatePasswordView()
}
