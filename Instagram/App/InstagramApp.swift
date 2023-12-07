//
//  InstagramApp.swift
//  Instagram
//
//  Created by darktech4 on 06/12/2023.
//

import SwiftUI

@main
struct InstagramApp: App {
    @AppStorage("colorScheme") var colorScheme = "dark"
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(getColorScheme())
        }
    }
    
    func getColorScheme() -> ColorScheme?{
        if colorScheme == "dark"{
            return .dark
        }else if colorScheme == "light"{
            return .light
        }else{
            return nil
        }
    }
}
