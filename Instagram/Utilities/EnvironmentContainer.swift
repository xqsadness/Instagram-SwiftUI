//
//  EnvironmentContainer.swift
//  Instagram
//
//  Created by iamblue on 04/01/2024.
//

import Foundation

// Environment Container
class EnvironmentContainer {
    static let shared = EnvironmentContainer()
    
    // Dependencies
    let registrationViewModel: RegistrationViewModel
    
    private init() {
        self.registrationViewModel = RegistrationViewModel()
    }
}
