//
//  UploadPostView.swift
//  Instagram
//
//  Created by iamblue on 11/12/2023.
//

import PhotosUI
import Observation
import SwiftUI

struct UploadPostView: View {
    @State private var caption = ""
    @State private var imagePickerPresented = false
         
    @Bindable var viewModel = UploadViewModel()
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack{
            //action tool bar
            HStack{
                Button{
                    caption = ""
                    viewModel.selectedImage = nil
                    viewModel.postImage = nil
                    tabIndex = 0
                }label: {
                    Text("Cancel")
                        .foregroundStyle(.blue)
                        .font(.regular(size: 16))
                }
                
                Spacer()
                
                Text("New post")
                    .foregroundStyle(.text)
                    .font(.semibold(size: 17))
                
                Spacer()
                
                Button{
                    
                }label: {
                    Text("Upload")
                        .foregroundStyle(.blue)
                        .font(.semibold(size: 16))
                }
            }
            .padding(.horizontal)
            
            //post image and caption
            HStack(spacing: 8){
                if let image = viewModel.postImage{
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .onTapGesture {
                            imagePickerPresented.toggle()
                        }
                }
                
                TextField("Enter your caption", text: $caption, axis: .vertical)
            }
            .padding()
            
            Spacer()
        }
        .onAppear{
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
