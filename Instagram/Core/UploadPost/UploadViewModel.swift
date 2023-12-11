//
//  UploadViewModel.swift
//  Instagram
//
//  Created by iamblue on 11/12/2023.
//

import Foundation
import Observation
import PhotosUI
import SwiftUI

@Observable
class UploadViewModel{
    
    //publicshed
    var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    var postImage: Image?
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        guard let uiImage = UIImage(data: data) else { return }
        
        self.postImage = Image(uiImage: uiImage)
        
    }
}
