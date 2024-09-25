import SwiftUI

struct ProfileImageView: View {
    var body: some View {
        Image("profile")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}
