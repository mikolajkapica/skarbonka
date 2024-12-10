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
        TopBar(title: "Help")
    }
}
