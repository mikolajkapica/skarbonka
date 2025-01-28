import SwiftUI

struct GoalConfirmationView: View {
    // MARK: - Properties
    @StateObject var viewModel: GoalConfirmationViewModel
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var style: StyleConfig
    @EnvironmentObject private var router: Router

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    goalMessage
                    iconView
                    dateMessage
                }
                .foregroundStyle(.white)
                .font(style.typography.m)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical)

                actionButtons
            }
            .padding(24)
        }
        .background(style.theme.backgroundGradient)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Components
private extension GoalConfirmationView {
    var goalMessage: some View {
        let msg = [
            String(localized: "Oszczędzaj "),
            "\(viewModel.goal.savePerFrequency)zł",
            String(
                localized:
                    " tygodniowo i ciesz się z zakupu \(viewModel.goal.name) za \(viewModel.goal.price) zl"
            ),
        ]

        return
            (Text(msg[0])
            + Text(msg[1]).foregroundStyle(style.theme.primary)
            + Text(msg[2]))
            .frame(maxWidth: CGFloat(290))
    }

    var iconView: some View {
        Image(systemName: viewModel.goal.icon)
            .foregroundColor(style.theme.background)
            .font(.system(size: 80))
            .frame(width: 170, height: 170)
            .background(style.theme.foreground)
            .clipShape(Circle())
    }

    var dateMessage: some View {
        Text(
            viewModel.futureDateMessage
                ?? String(localized: "Nie udalo sie obliczyc daty"))
    }

    var actionButtons: some View {
        VStack(spacing: 16) {
            saveButton
            cancelButton
        }
    }

    var saveButton: some View {
        Button(action: saveGoal) {
            Text(String(localized: "Zapisz cel"))
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(style.theme.primary)
                .cornerRadius(.infinity)
        }
        .accessibilityIdentifier("saveButton")
    }

    var cancelButton: some View {
        Button(action: dismissView) {
            Text(String(localized: "Anuluj"))
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(style.theme.foreground)
                .cornerRadius(.infinity)
        }
    }
}

// MARK: - Actions
private extension GoalConfirmationView {
    func saveGoal() {
        viewModel.saveGoal()
        router.goHome()
    }

    func dismissView() {
        router.path.removeLast()
    }
}

// MARK: - Preview
#Preview {
    GoalConfirmationView(
        viewModel: GoalConfirmationViewModel.preview()
    )
    .modelContainer(DataController.previewContainer)
    .environmentObject(Router(modelContext: DataController.previewContainer.mainContext))
    .environmentObject(StyleConfig.preview)
}
