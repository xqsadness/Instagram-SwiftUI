//
//  FeedView.swift
//  Instagram
//
//  Created by darktech4 on 07/12/2023.
//

import SwiftUI

struct FeedView: View {
    @AppStorage("colorScheme") var colorScheme = "dark"
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 32){
                    ForEach(0...10, id: \.self){ post in
                        FeedCell()
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(getColorScheme() == .dark ? .igLogoWhite : .igLogoBlack)
                        .resizable()
                        .frame(width: 110, height: 110)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
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

#Preview {
    FeedView()
}
