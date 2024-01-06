//
//  EditProfileView.swift
//  Instagram
//
//  Created by iamblue on 05/01/2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack{
            //Tool bar
            toolBar
            
            Divider()
            
            //Edit profile pic
            editPicture
            
            //Edit profile info
            VStack{
                EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $viewModel.fullname)
                
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $viewModel.bio)
            }
            
            Spacer()
        }
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack{
            Text(title)
                .padding(.leading, 8)
                .foregroundStyle(.text)
                .font(.semibold(size: 15))
                .frame(width: 100, alignment: .leading)
            
            VStack{
                TextField(placeholder, text: $text)
                    .foregroundStyle(.text)
                    .font(.semibold(size: 15))
                
                Divider()
            }
        }
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}

extension EditProfileView{
    
    private var toolBar: some View{
        HStack{
            Button{
                dismiss()
            }label: {
                Text("Cancel")
                    .font(.bold(size: 15))
                    .foregroundStyle(.blue)
            }
            
            Spacer()
            
            Text("Edit profile")
                .font(.semibold(size: 15))
                .foregroundStyle(.text)
            
            Spacer()
            
            Button{
                Task {
                    try await viewModel.updateUserData()
                    dismiss()
                }
            }label: {
                Text("Done")
                    .font(.bold(size: 15))
                    .foregroundStyle(.blue)
            }
        }
        .padding(.horizontal)
    }
    
    private var editPicture: some View{
        PhotosPicker(selection: $viewModel.selectedImage){
            VStack{
                if let image = viewModel.profileImage{
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }else{
                    CircularProfileImageView(user: viewModel.user, size: .large)
                }
                
                Text("Edit profile picture")
                    .font(.semibold(size: 15))
                    .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 8)
    }
}
