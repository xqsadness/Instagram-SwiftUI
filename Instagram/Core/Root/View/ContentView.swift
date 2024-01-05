//
//  ContentView.swift
//  Instagram
//
//  Created by iamblue on 06/12/2023.
//

import SwiftUI
import Observation

struct ContentView: View {
    var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil{
                LoginView()
            }else if let currentUser = viewModel.currentUser{
                MainTabView(user: currentUser)
            }
        }
    }
}

#Preview {
    ContentView()
}
