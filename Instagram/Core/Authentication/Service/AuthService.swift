//
//  AuthService.swift
//  Instagram
//
//  Created by iamblue on 12/12/2023.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class AuthService{
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init(){
        Task{ try await loadUserData() }
    }
    
    func login(with email: String, password: String) async throws {
        do{
            let rs = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = rs.user
            try await loadUserData()
        }catch{
            print("Debug: failed to login with error \(error.localizedDescription)")
        }
    }
    
    func createUser(email: String, password: String, username: String) async throws {
        do{
            let rs = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = rs.user
            await self.uploadUserData(uid: rs.user.uid, username: username, email: email)
        }catch{
            print("Debug: failed to register user with error \(error.localizedDescription)")
        }
    }
    
    func loadUserData() async throws{
        self.userSession = Auth.auth().currentUser

        guard let currentUID = userSession?.uid else { return }
        self.currentUser = try await UserService.fetchUser(withUid: currentUID)
    }
    
    func signout(){
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
