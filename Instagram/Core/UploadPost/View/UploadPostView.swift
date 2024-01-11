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
         
    @Bindable var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int
    @Binding var isLoading: Bool
    
    var uploadSuccess: (() -> Void)
    
    var body: some View {
        VStack{
            //action tool bar
            HStack{
                Button{
                    clearPostDataAndReturnToFeed()
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
                    Task{
                        try await viewModel.uploadPost(caption: caption)
                        clearPostDataAndReturnToFeed()
                        uploadSuccess()
                    }
                }label: {
                    Text("Upload")
                        .foregroundStyle(.blue)
                        .font(.semibold(size: 16))
                }
                .disabled(viewModel.postImage == nil && caption.isEmpty ? true : false)
                .opacity(viewModel.postImage == nil && caption.isEmpty ? 0.5 : 1)
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
        .onChange(of: viewModel.isLoading, { _, newValue in
            self.isLoading = newValue
        })
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    
    func clearPostDataAndReturnToFeed(){
        tabIndex = 0
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0), isLoading: .constant(false)){}
}
