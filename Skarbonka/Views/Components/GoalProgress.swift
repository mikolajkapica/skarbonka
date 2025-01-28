import SwiftUI

struct GoalProgress: View {
    // MARK: - Properties
    let progress: Float
    let icon: String
    let size: CGFloat = 150
    let lineWidth: CGFloat = 10
    
    @EnvironmentObject private var style: StyleConfig
    
    // MARK: - Body
    var body: some View {
        ZStack {
            backgroundCircle
            progressCircle
        }
        .overlay(iconOverlay)
        .frame(width: size, height: size)
    }
}

// MARK: - Components
private extension GoalProgress {
    var backgroundCircle: some View {
        Circle()
            .stroke(Color.white.opacity(0.1), lineWidth: lineWidth)
            .rotationEffect(.degrees(-90))
    }
    
    var progressCircle: some View {
        Circle()
            .trim(from: 0, to: CGFloat(progress))
            .stroke(style.theme.primary, lineWidth: lineWidth)
            .rotationEffect(.degrees(-90))
    }
    
    var iconOverlay: some View {
        Image(systemName: icon)
            .foregroundColor(style.theme.background)
            .font(.system(size: 64))
            .frame(width: size - lineWidth / 2, height: size - lineWidth / 2)
            .background(style.theme.foreground)
            .clipShape(Circle())
    }
}

// MARK: - Preview
#Preview {
    GoalProgress(progress: 0.75, icon: "ticket")
        .environmentObject(StyleConfig())
}
