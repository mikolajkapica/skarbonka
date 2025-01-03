import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            TopBar(title: "Profil")
            Spacer()
            Text("Znalazłeś się w nieodkrytym miejscu!")
                .padding(16)
                .foregroundStyle(.white)
            Spacer()
        }
        .background(SkarbonkaColors.PurpleGradient)
    }
}
