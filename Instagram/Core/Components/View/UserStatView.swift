
import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    var body: some View {
        VStack(spacing: 3){
            Text("\(value)")
                .font(.semibold(size: 17))
                .foregroundStyle(.text)
            
            Text("\(title)")
                .font(.semibold(size: 16))
                .foregroundStyle(.text)
        }
        .frame(width: 80)
    }
}

