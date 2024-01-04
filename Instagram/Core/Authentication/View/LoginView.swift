//
//  LoginView.swift
//  Instagram
//
//  Created by iamblue on 07/12/2023.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("colorScheme") var colorScheme = "dark"
    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack{
            Spacer()
            
            //logo image
            Image(getColorScheme() == .dark ? .igLogoWhite : .igLogoBlack)
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 100)

            // text fields
            VStack{
                TextField("Enter your email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(IGTextFieldModifier())
                
                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(IGTextFieldModifier())
            }
            
            Button{
                print("forgot password")
            }label: {
                Text("Forgot Password ?")
                    .font(.semibold(size: 13))
                    .padding(.top)
                    .padding(.trailing, 28)
            }
            .hAlign(.trailing)
            
            Button{
                Task{ try await viewModel.signIn() }
            }label: {
                Text("Login")
                    .font(.semibold(size: 13))
                    .foregroundStyle(.white)
                    .frame(width: 360, height: 44)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            HStack{
                Rectangle()
                    .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                
                Text("OR")
                    .font(.semibold(size: 14))
                
                Rectangle()
                    .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
            }
            .foregroundStyle(.gray)
            
            HStack{
                Image(.fbLogo)
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text("Continue with facebook")
                    .font(.semibold(size: 14))
                    .foregroundStyle(.blue)
            }
            .padding(.top, 8)
            
            Spacer()
            
            HStack(spacing: 3){
                Text("Dont't have account?")
                    .font(.regular(size: 14))
                
                Text("Sign up")
                    .font(.bold(size: 14))
            }
            .foregroundStyle(.blue)
            .padding(.vertical,16)
            .onTapGesture {
                coordinator.push(.addEmailView)
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
    LoginView()
        .environmentObject(Coordinator.shared)
}
