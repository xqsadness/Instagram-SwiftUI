//
//  CircularProfileImageView.swift
//  Instagram
//
//  Created by iamblue on 05/01/2024.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize{
    case xSmall
    case small
    case medium
    case large
    
    var dimension: CGFloat{
        switch self{
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 80
        }
    }
}

struct CircularProfileImageView: View {
    let user: User
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user.profileImageUrl{
            KFImage(URL(string: imageUrl))
                .resizable()
                .placeholder{
                    Image(.df)
                        .resizable()
                        .frame(width: size.dimension, height: size.dimension)
                        .scaledToFill()
                        .clipShape(Circle())
                }
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        }else{
            Image(.avtT)
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USERS[0], size: .medium)
}
