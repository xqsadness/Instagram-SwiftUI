//
//  IGTextFieldModifier.swift
//  Instagram
//
//  Created by iamblue on 08/12/2023.
//

import SwiftUI

struct IGTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.regular(size: 14))
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}

