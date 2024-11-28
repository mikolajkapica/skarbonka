import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode // Used to dismiss the view
    var body: some View {
        VStack {
            TopBar(title: "Praaofile")
            Text("ihsgdsdsdgsdgdsgsdgdsg")
                .padding(16)
            Spacer()

            
        }
        .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss() // Custom back action
                        }) {
                            HStack {
                                Image(systemName: "arrow.left") // Custom back arrow icon
                                Text("Back") // Optional label for the back button
                            }
                            .foregroundColor(.blue) // Custom color for the button
                        }
                    }
                }
        .navigationBarHidden(true)
        .background(Color.red)
        
    }
}
