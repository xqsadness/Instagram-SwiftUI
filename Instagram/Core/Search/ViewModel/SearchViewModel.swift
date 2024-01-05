//
//  SearchViewModel.swift
//  Instagram
//
//  Created by iamblue on 05/01/2024.
//

import Foundation

@Observable
class SearchViewModel{
    var users = [User]()
    
    init(){
        Task{ try await fetchAllUser() }
    }
    
    func fetchAllUser() async throws {
        self.users = try await UserService.fetchAllUser()
    }
}
