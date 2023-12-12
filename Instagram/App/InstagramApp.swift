//
//  InstagramApp.swift
//  Instagram
//
//  Created by iamblue on 06/12/2023.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct InstagramApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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
                .navigationDestination(for: User.self) { user in
                    ProfileView(user: user)
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(Coordinator.shared)
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
