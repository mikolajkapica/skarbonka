import SwiftUI

struct GoalIcon: View {
    let progress: Float
    let size: CGFloat = 150
    let lineWidth: CGFloat = 10
    var icon: String
    @EnvironmentObject private var style: StyleConfig

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.1), lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(style.theme.primary, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
        }
        .overlay(
            Image(systemName: icon)
                .foregroundColor(style.theme.background)
                .font(.system(size: 64))
                .frame(
                    width: size - lineWidth / 2, height: size - lineWidth / 2
                )
                .background(style.theme.foreground)
                .clipShape(Circle())
        )
        .frame(width: size, height: size)
    }
}

#Preview {
    GoalIcon(
        progress: 0.75,
        icon: "ticket"
    )
    .environmentObject(StyleConfig())
}
