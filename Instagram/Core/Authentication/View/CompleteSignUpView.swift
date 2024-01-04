//
//  CompleteSignUpView.swift
//  Instagram
//
//  Created by iamblue on 08/12/2023.
//

import SwiftUI

struct CompleteSignUpView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewModel: RegistrationViewModel
    
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
            
            Spacer()

            Text("Welcome to Instagram, \(viewModel.username)")
                .font(.bold(size: 20))
                .padding(.top)
            
            Text("Click be low to complete registration and start using Instagram")
                .font(.regular(size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button{
                Task{
                    try await viewModel.createUser()
                    coordinator.popToRoot()
                }
            }label: {
                Text("Complete sign up")
                    .font(.semibold(size: 13))
                    .foregroundStyle(.white)
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
    CompleteSignUpView()
}
