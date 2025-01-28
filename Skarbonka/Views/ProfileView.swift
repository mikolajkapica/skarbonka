import SwiftUI
import SwiftData
import PhotosUI

struct ProfileView: View {
    // MARK: - Properties
    @EnvironmentObject var style: StyleConfig
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [GoalModel]
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    
    private var totalSaved: Int {
        goals.reduce(0) { $0 + $1.saved }
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            profileImageSection
            savingsSection
            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(style.theme.backgroundGradient)
        .topBarTitle(String(localized: "Profil"))
    }
}

// MARK: - Components
private extension ProfileView {
    var profileImageSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let profileImage {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(style.theme.primary, lineWidth: 3))
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundStyle(style.theme.foreground)
                    .frame(width: 120, height: 120)
            }
            
            PhotosPicker(selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                Text(String(localized: "Zmień zdjęcie"))
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(style.theme.primary)
                    .clipShape(Capsule())
            }
        }
        .padding(.top, 32)
        .onChange(of: selectedItem) { _, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    profileImage = Image(uiImage: uiImage)
                }
            }
        }
    }
    
    var savingsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(String(localized: "Twoje oszczędności"))
                .font(.headline)
                .foregroundStyle(.white)
            
            Text("\(totalSaved) \(String(localized: "zł"))")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(style.theme.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
        }
    }
}

// MARK: - Preview Helpers
#if DEBUG
#Preview {
    ProfileView()
        .environmentObject(StyleConfig.preview)
        .modelContainer(DataController.previewContainer)
}
#endif
