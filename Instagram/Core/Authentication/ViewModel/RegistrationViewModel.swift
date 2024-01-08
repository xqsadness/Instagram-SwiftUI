//
//  RegistrationViewModel.swift
//  Instagram
//
//  Created by iamblue on 04/01/2024.
//

import Foundation

class RegistrationViewModel: ObservableObject{
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func createUser(onSuccess: @escaping (Bool) -> Void) async throws{
        try await AuthService.shared.createUser(email: email, password: password, username: username){ success, err in
            if success{
                self.username = ""
                self.email = ""
                self.password = ""
                
                Toast.shared.present(
                    title: "Sign up success",
                    symbol: "checkmark",
                    isUserInteractionEnabled: true,
                    timing: .long,
                    position: .bottom
                )
                onSuccess(true)
            }else{
                Toast.shared.present(
                    title: String(err?.localizedDescription ?? "Nil"),
                    symbol: "",
                    isUserInteractionEnabled: true,
                    timing: .long,
                    position: .bottom
                )
                onSuccess(false)
            }
        }
    }
}
