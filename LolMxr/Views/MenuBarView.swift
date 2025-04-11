import SwiftUI

struct MenuBarView: View {
    var body: some View {
        VStack(spacing: 8) {
            Button("Show Mixer") {
                // Показать микшер
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
                
                
                Image(systemName: "speaker.wave.3")
                    .resizable()
                    .frame(width: 18, height: 18)
            }
        }
        .padding(8)
    }
}
