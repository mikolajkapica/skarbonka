import SwiftUI


struct TopBar: View {
    @ObservedObject var viewModel = TopBarViewModel.shared
    @EnvironmentObject var style: StyleConfig
    @EnvironmentObject var router: Router

    var body: some View {
        HStack {
            if viewModel.isBack {
                Button(action: {
                    router.path.removeLast()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(style.theme.primary)
                }
            }
            Text(viewModel.title).font(style.typography.m)
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

    init(title: String = "", isBack: Bool = false) {
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
