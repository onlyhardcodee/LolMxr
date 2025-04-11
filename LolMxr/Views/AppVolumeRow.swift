import SwiftUI

struct AppVolumeRow: View {
    @Binding var app: AudioApp
    
    var body: some View {
            HStack(spacing: 12) {
                AppIconView(icon: app.icon)
                AppNameView(name: app.name)
                VolumeSlider(volume: $app.volume)
                VolumePercentage(volume: app.volume)
                MuteButton(isMuted: $app.isMuted)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .onChange(of: app.volume) { newValue in
                AudioManager.shared.setVolume(for: app.pid, volume: newValue)
            }
            .onChange(of: app.isMuted) { isMuted in
                AudioManager.shared.setVolume(for: app.pid, volume: isMuted ? 0 : app.volume)
            }
        }
    
    private func AppIconView(icon: NSImage) -> some View {
        Image(nsImage: icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
    }
    
    private func AppNameView(name: String) -> some View {
        Text(name)
            .font(.system(size: 12))
            .frame(width: 100, alignment: .leading)
            .lineLimit(1)
    }
    
    private func VolumeSlider(volume: Binding<Float>) -> some View {
        Slider(value: volume, in: 0...1)
            .frame(width: 120)
    }
    
    private func VolumePercentage(volume: Float) -> some View {
        Text("\(Int(volume * 100))%")
            .font(.system(size: 10))
            .frame(width: 30)
    }
    
    private func MuteButton(isMuted: Binding<Bool>) -> some View {
        Button(action: { isMuted.wrappedValue.toggle() }) {
            Image(systemName: isMuted.wrappedValue ? "speaker.slash.fill" : "speaker.wave.2.fill")
                .frame(width: 20)
        }
        .buttonStyle(.plain)
    }
}
