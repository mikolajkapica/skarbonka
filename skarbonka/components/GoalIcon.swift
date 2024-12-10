import SwiftUI

struct GoalIcon: View {
    let progress: Float
    let size: CGFloat = 150
    let lineWidth: CGFloat = 10
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.1), lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(SkarbonkaColors.Orange, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
        }
        .overlay(
            Image(systemName: "ticket")
                .foregroundColor(SkarbonkaColors.black)
                .font(.system(size: 64))
                .frame(
                    width: size - lineWidth / 2, height: size - lineWidth / 2
                )
                .background(SkarbonkaColors.white)
                .clipShape(Circle())
        )
        .frame(width: size, height: size)
    }
}
