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
    @StateObject var coordinator = Coordinator.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                Group{
                    ContentView()
                        .preferredColorScheme(getColorScheme())
                }
                .environmentObject(coordinator)
                .navigationBarHidden(true)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreencover in
                    coordinator.build(fullScreenCover: fullScreencover)
                }
            }
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
