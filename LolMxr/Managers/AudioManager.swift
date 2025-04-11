import CoreAudio
import Cocoa

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    @Published var audioApps: [AudioApp] = []
    
    private let systemOutputDevice: AudioDeviceID
    
    init() {
        self.systemOutputDevice = AudioSystem.getDefaultOutputDevice()
        refreshApps()
    }
    
    func refreshApps() {
        let runningApps = NSWorkspace.shared.runningApplications
            .filter { $0.activationPolicy == .regular }
        
        audioApps = runningApps.compactMap { app in
            guard let bundleId = app.bundleIdentifier,
                  let icon = app.icon else { return nil }
            
            let currentVolume = getVolumeForApp(pid: app.processIdentifier)
            
            return AudioApp(
                id: bundleId,
                name: app.localizedName ?? "Unknown",
                pid: app.processIdentifier,
                icon: icon,
                volume: currentVolume,
                isMuted: currentVolume == 0
            )
        }
    }
    
    func setVolume(for pid: pid_t, volume: Float) {
        // Для системной громкости
        if pid == 0 {
            setSystemVolume(volume)
            return
        }
        
        // Для конкретного приложения
        setAppVolume(pid: pid, volume: volume)
        
        // Обновляем UI
        if let index = audioApps.firstIndex(where: { $0.pid == pid }) {
            audioApps[index].volume = volume
            audioApps[index].isMuted = volume == 0
        }
    }
    
    private func getVolumeForApp(pid: pid_t) -> Float {
        return 0.5
    }
    
    private func setSystemVolume(_ volume: Float) {
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioDevicePropertyVolumeScalar,
            mScope: kAudioDevicePropertyScopeOutput,
            mElement: kAudioObjectPropertyElementMain
        )
        
        var volume = volume
        AudioObjectSetPropertyData(
            systemOutputDevice,
            &address,
            0,
            nil,
            UInt32(MemoryLayout<Float>.size),
            &volume
        )
    }
    
    private func setAppVolume(pid: pid_t, volume: Float) {

        print("Setting volume \(volume) for app with PID: \(pid)")
    }
}
