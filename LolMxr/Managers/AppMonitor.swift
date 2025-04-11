import Cocoa

class AppMonitor {
    static let shared = AppMonitor()
    
    func startMonitoring() {
        let center = NSWorkspace.shared.notificationCenter
        
        center.addObserver(
            forName: NSWorkspace.didLaunchApplicationNotification,
            object: nil,
            queue: .main
        ) { _ in
            AudioManager.shared.refreshApps()
        }
        
        center.addObserver(
            forName: NSWorkspace.didTerminateApplicationNotification,
            object: nil,
            queue: .main
        ) { _ in
            AudioManager.shared.refreshApps()
        }
    }
}
