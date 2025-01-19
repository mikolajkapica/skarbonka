import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var style: StyleConfig
    var body: some View {
        VStack {
            Spacer()
            Text("Znalazłeś się w nieodkrytym miejscu!")
                .padding(16)
                .foregroundStyle(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(style.theme.backgroundGradient)
    }
}
