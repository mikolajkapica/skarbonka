import SwiftUI

struct TopBar: View {
    @ObservedObject var viewModel = TopBarViewModel.shared
    @EnvironmentObject var style: StyleConfig
    @EnvironmentObject var router: Router

    var body: some View {
        HStack {
            if !router.path.isEmpty {
                Button(action: {
                    router.path.removeLast()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(style.theme.primary)
                }
            }
            Text(viewModel.title)
                .font(style.typography.m)
                .bold()
            Spacer()
            Button(action: {
                print(router.path)
            }) {
                Image("FaceTalking")
            }
            Image("Bell")
        }
        .contentMargins(0)
        .padding(16)
        .background(.white)
    }
}

class TopBarViewModel: ObservableObject {
    static let shared = TopBarViewModel()

    @Published var title: String
    @Published var isBack: Bool

    private init(title: String = "", isBack: Bool = false) {
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
                TopBarViewModel.shared.title = title
            }
    }
}

extension View {
    func topBarTitle(_ title: String) -> some View {
        self.modifier(TopBarTitleModifier(title: title))
    }
}

#Preview {
    let viewModel = TopBarViewModel.shared
    viewModel.title = "Title"
    return TopBar(viewModel: viewModel)
        .environmentObject(StyleConfig())
}
