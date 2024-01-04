//
//  LoginViewModel.swift
//  Instagram
//
//  Created by iamblue on 04/01/2024.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
       try await AuthService.shared.login(with: email, password: password)
    }
}

