import CoreAudio

struct AudioDevice {
    let id: AudioObjectID
    let name: String
    var isInput: Bool
    var isOutput: Bool
}
