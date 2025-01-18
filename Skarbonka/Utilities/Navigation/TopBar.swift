import SwiftUI


struct TopBar: View {
    @ObservedObject var viewModel = TopBarViewModel.shared

    var body: some View {
        HStack {
            if viewModel.isBack {
                Button(action: {
                    Router.shared.back()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(SkarbonkaColors.Orange)
                }
            }
            Text(viewModel.title)
                .withSize(.ml)
                .bold()
            Spacer()
            Image("FaceTalking")
            Image("Bell")
        }
        .navigationBarBackButtonHidden(true)
        .contentMargins(0)
        .padding(16)
        .background(.white)
    }
}

struct TopBarPreview_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(viewModel: TopBarViewModel(title: "Skarbonka", isBack: false))
    }
}

class TopBarViewModel: ObservableObject {
    static let shared = TopBarViewModel()
    
    @Published var title: String
    @Published var isBack: Bool

    init(title: String = "XXX", isBack: Bool = true) {
        self.title = title
        self.isBack = isBack
    }

    func handleBackAction() {
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

struct TopBarTitleModifier: ViewModifier {
    var title: String
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                TopBarViewModel.shared.title = title  // Update singleton title
            }
    }
}

extension View {
    func topBarTitle(_ title: String) -> some View {
        self.modifier(TopBarTitleModifier(title: title))
    }
}
