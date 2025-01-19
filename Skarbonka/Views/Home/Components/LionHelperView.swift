import SwiftUI

struct LionHelper: View {
    @State private var showBubble: Bool = false
    
    @EnvironmentObject var style: StyleConfig

    var closeButton: some View {
        Button(action: {
            withAnimation {
                showBubble = false
            }
        }) {
            Image("close")
                .padding(15)
        }
    }

    var volumeUpButton: some View {
        Button(action: {}) {
            Image("volume_up")
                .padding(15)
        }
    }

    var lionButton: some View {
        Button(action: {
            withAnimation(.bouncy(duration: 0.1)) {
                showBubble.toggle()
            }
        }) {
            Image("lion")
        }
    }

    var bubble: some View {
        VStack(alignment: .trailing) {
            Text(
                String(
                    localized:
                        "Naciśnij profil osoby, z którą chcesz zagrać albo dodaj nowego znajomego."
                )
            )
            .padding()
            .padding(.trailing, 20)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style.theme.primary, lineWidth: 3)
            )
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .transition(.scale)
            .overlay(closeButton, alignment: .topTrailing)
            .overlay(volumeUpButton, alignment: .bottomTrailing)
            .offset(y: -30)
        }
    }

    var body: some View {
        HStack {
            Spacer()
            if showBubble {
                bubble
            }
            lionButton
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    LionHelper()
        .environmentObject(StyleConfig())
}
