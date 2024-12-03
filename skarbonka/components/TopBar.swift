import SwiftUI

struct TopBar: View {
    var title: String
    var isBack: Bool = true
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack {
            if isBack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left").foregroundColor(
                        SkarbonkaColors.Orange)
                }
            }
            Text(title).withSize(.ml).bold()
            Spacer()
            Image(systemName: "bell")
        }
        .navigationBarBackButtonHidden(true)
        .contentMargins(0)
        .padding(16)
        .background(.white)
        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
        
    }
}

struct TopBarPreview_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(title: "Help")
    }
}
