import AppKit

struct AudioApp: Identifiable {
    let id: String // Bundle ID
    let name: String
    let pid: pid_t
    let icon: NSImage
    var volume: Float
    var isMuted: Bool
}
