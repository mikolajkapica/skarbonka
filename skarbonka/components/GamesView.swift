import SwiftUI

struct GamesView: View {
    var body: some View {
        VStack {
            TopBar(title: "Gry")
            Spacer()
            Text("Znalazłeś się w nieodkrytym miejscu!")
                .padding(16)
                .foregroundStyle(.white)
            Spacer()
        }
        .background(SkarbonkaColors.PurpleGradient)
    }
}
