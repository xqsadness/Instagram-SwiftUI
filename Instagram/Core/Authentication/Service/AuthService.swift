//
//  AuthService.swift
//  Instagram
//
//  Created by iamblue on 12/12/2023.
//

import Foundation
import FirebaseAuth

class AuthService{
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
    
    func login(with email: String, password: String) async throws {
        
    }
    
    func createUser(email: String, password: String, username: String) async throws {
        do{
            let rs = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = rs.user
        }catch{
            print("Debug: failed to register user with error \(error.localizedDescription)")
        }
    }
    
    func loadUserData() async throws{
        
    }
    
    func signout(){
        
    }
}
