//
//  ContentViewModel.swift
//  Instagram
//
//  Created by iamblue on 12/12/2023.
//

import Foundation
import Observation
import Firebase
import Combine

@Observable
class ContentViewModel {
    
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    var userSession: FirebaseAuth.User?
    
    init(){
        setupSubcribers()
    }
    
    func setupSubcribers(){
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
    }
    
}
