import SwiftUI

struct LionHelper: View {
    @State private var showBubble: Bool = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                if showBubble {
                    VStack(alignment: .trailing) {
                        Text(
                            "Naciśnij profil osoby, z którą chcesz zagrać albo dodaj nowego znajomego."
                        )
                    }
                    .padding()
                    .padding(.trailing, 20)
                    .background(Color.white)  // White background for the bubble
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(SkarbonkaColors.Orange, lineWidth: 3)
                    )
                    .foregroundColor(.black)  // Text color
                    .multilineTextAlignment(.leading)
                    .transition(.scale)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                showBubble = false
                            }
                        }) {
                            Image("close")
                                .padding(15)
                        },
                        alignment: .topTrailing
                    )
                    .overlay(
                        Button(action: {
                            withAnimation {
                                showBubble = false
                            }
                        }) {
                            Image("volume_up")
                                .padding(15)
                        },
                        alignment: .bottomTrailing
                    )
                    .offset(y: -15)
                }

                // Lion button
                Button(action: {
                    withAnimation {
                        showBubble.toggle()
                    }
                }) {
                    Image("lion")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
                .buttonStyle(PlainButtonStyle())  // Removes default button styles
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
    }
}

struct LionHelper_Previews: PreviewProvider {
    static var previews: some View {
        LionHelper()
    }
}
