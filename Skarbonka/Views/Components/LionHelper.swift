import SwiftUI

class LionHelperViewModel: ObservableObject {
    // MARK: - Singleton
    static let shared = LionHelperViewModel()
    
    // MARK: - Published Properties
    @Published var message: String
    
    // MARK: - Initialization
    private init() {
        self.message = String(
            localized: "Naciśnij profil osoby, z którą chcesz zagrać albo dodaj nowego znajomego."
        )
    }
    
    // MARK: - Public Methods
    func updateMessage(_ newMessage: String) {
        message = newMessage
    }
}

struct LionMessageModifier: ViewModifier {
    let message: String
    
    func body(content: Content) -> some View {
        content.onAppear {
            LionHelperViewModel.shared.updateMessage(message)
        }
    }
}

extension View {
    func lionMessage(_ message: String) -> some View {
        modifier(LionMessageModifier(message: message))
    }
}

struct LionHelper: View {
    // MARK: - Properties
    @State private var showBubble: Bool = false
    @ObservedObject private var viewModel = LionHelperViewModel.shared
    @EnvironmentObject private var style: StyleConfig
    
    // MARK: - Body
    var body: some View {
        HStack {
            Spacer()
            if showBubble {
                messageBubble
            }
            lionButton
                .offset(y: 10)
        }
    }
}

// MARK: - Components
private extension LionHelper {
    var messageBubble: some View {
        VStack(alignment: .trailing) {
            Text(viewModel.message)
                .padding()
                .padding(.trailing, 20)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(bubbleBorder)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .transition(.scale)
                .overlay(closeButton, alignment: .topTrailing)
                .overlay(volumeUpButton, alignment: .bottomTrailing)
                .offset(y: -30)
        }
    }
    
    var bubbleBorder: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(style.theme.primary, lineWidth: 3)
    }
    
    var closeButton: some View {
        Button(action: hideBubble) {
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
        Button(action: toggleBubble) {
            Image("lion")
        }
    }
    
    func hideBubble() {
        withAnimation {
            showBubble = false
        }
    }
    
    func toggleBubble() {
        withAnimation(.bouncy(duration: 0.1)) {
            showBubble.toggle()
        }
    }
}

// MARK: - Preview Helpers
#if DEBUG
extension LionHelperViewModel {
    static var preview: LionHelperViewModel {
        shared
    }
}

#Preview {
    LionHelper()
        .environmentObject(StyleConfig.preview)
}
#endif
