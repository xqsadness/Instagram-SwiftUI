//
//  SearchView.swift
//  Instagram
//
//  Created by iamblue on 08/12/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVStack(spacing: 12){
                    ForEach(User.MOCK_USERS){ user in
                        NavigationLink(value: user) {
                            HStack{
                                Image(user.profileImageUrl ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading){
                                    Text("\(user.username)")
                                        .font(.semibold(size: 14))
                                        .foregroundStyle(.text)
                                    
                                    if let fullname = user.fullname{
                                        Text("\(fullname)")
                                            .font(.regular(size: 14))
                                            .foregroundStyle(.text)
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
