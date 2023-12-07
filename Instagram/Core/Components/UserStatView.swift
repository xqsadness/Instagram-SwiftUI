
import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    var body: some View {
        VStack{
            Text("\(value)")
                .font(.semibold(size: 15))
                .foregroundStyle(.text)
            
            Text("\(title)")
                .font(.regular(size: 14))
                .foregroundStyle(.text)
        }
        .frame(width: 72)
    }
}

