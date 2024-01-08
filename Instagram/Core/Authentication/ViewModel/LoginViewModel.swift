//
//  LoginViewModel.swift
//  Instagram
//
//  Created by iamblue on 04/01/2024.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject{
    
    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
        isLoading = true
        try await AuthService.shared.login(with: email, password: password)
        isLoading = false
    }
}

