import SwiftUI

// MARK: - TopBar View
struct TopBar: View {
    // MARK: - Properties
    @ObservedObject var viewModel = TopBarViewModel.shared
    @EnvironmentObject var style: StyleConfig
    @EnvironmentObject var router: Router
    
    // MARK: - Body
    var body: some View {
        HStack {
            backButton
            titleText
            Spacer()
            actionButtons
        }
        .contentMargins(0)
        .padding(16)
        .background(.white)
    }
}

// MARK: - Components
private extension TopBar {
    @ViewBuilder
    var backButton: some View {
        if !router.path.isEmpty {
            Button(action: router.goBack) {
                Image(systemName: "arrow.left")
                    .foregroundColor(style.theme.primary)
            }
        }
    }
    
    var titleText: some View {
        Text(viewModel.title)
            .font(style.typography.m)
            .bold()
    }
    
    var actionButtons: some View {
        HStack {
            Button(action: { print(router.path) }) {
                Image("FaceTalking")
            }
            Image("Bell")
        }
    }
}

// MARK: - TopBar ViewModel
class TopBarViewModel: ObservableObject {
    // MARK: - Properties
    static let shared = TopBarViewModel()
    
    @Published var title: String
    @Published var isBack: Bool
    
    // MARK: - Initialization
    private init(title: String = "", isBack: Bool = false) {
        self.title = title
        self.isBack = isBack
    }
    
    // MARK: - Public Methods
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

// MARK: - View Modifiers
struct TopBarTitleModifier: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        content.onAppear {
            TopBarViewModel.shared.title = title
        }
    }
}

// MARK: - View Extensions
extension View {
    func topBarTitle(_ title: String) -> some View {
        modifier(TopBarTitleModifier(title: title))
    }
}

// MARK: - Preview
#Preview {
    let viewModel = TopBarViewModel.shared
    viewModel.title = "Title"
    return TopBar(viewModel: viewModel)
        .environmentObject(StyleConfig())
}

// MARK: - Preview Helpers
#if DEBUG
extension TopBarViewModel {
    static var preview: TopBarViewModel {
        let viewModel = TopBarViewModel.shared
        viewModel.title = "Preview Title"
        return viewModel
    }
}

#Preview {
    TopBar(viewModel: TopBarViewModel.preview)
        .environmentObject(StyleConfig.preview)
        .environmentObject(Router.preview())
}
#endif
