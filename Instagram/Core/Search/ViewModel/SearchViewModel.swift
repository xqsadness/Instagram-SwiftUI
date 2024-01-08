//
//  SearchViewModel.swift
//  Instagram
//
//  Created by iamblue on 05/01/2024.
//

import Foundation
import Combine
import Firebase

@MainActor
class SearchViewModel: ObservableObject{
    
    @Published var users = [User]()
    @Published var oldUsers = [User]()
    @Published var searchText = ""
    
    var cancellables: Set<AnyCancellable> = []
    
    init(){
        Task{ try await fetchAllUser() }
        
        searchUser()
    }
    
    func fetchAllUser() async throws {
        guard let currenUID = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUser()
        self.users = users.filter({ $0.id != currenUID })
        self.oldUsers = self.users
    }
    
    func searchUser(){
        guard let currenUID = Auth.auth().currentUser?.uid else { return }
        
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ searchText in
                guard !searchText.isEmpty else{
                    return self.users
                }
                
                return self.users.filter( {
                    $0.username.lowercased().contains(searchText.lowercased())
                    || $0.email.lowercased().contains(searchText.lowercased())
                    && $0.id != currenUID
                } )
            }
            .sink { [weak self] returnedSearch in
                guard let self = self else { return }
                
                self.users = returnedSearch
                
                if searchText.isEmpty {
                    self.users = self.oldUsers
                }
            }
            .store(in: &cancellables)
    }
}
