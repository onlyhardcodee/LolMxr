import SwiftUI

extension View {
    func withHoverEffect() -> some View {
        self
            .padding(4)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(4)
            .onHover { inside in
                if inside {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
    }
    
    func windowBackground() -> some View {
        self
            .background(Color(NSColor.windowBackgroundColor))
    }
}
