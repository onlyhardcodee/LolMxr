import SwiftUI

struct MixerView: View {
    @ObservedObject var audioManager = AudioManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            Divider()
            AppListView()
            FooterControls()
        }
        .frame(width: 350, height: 500)
        .onAppear {
            audioManager.refreshApps()
        }
    }
    
    private func HeaderView() -> some View {
        HStack {
            Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                .resizable()
                .frame(width: 20, height: 20)
            Text("LolMxr").font(.headline)
            Spacer()
        }
        .padding()
    }
    
    private func AppListView() -> some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach($audioManager.audioApps) { $app in
                    AppVolumeRow(app: $app)
                }
            }
            .padding(.horizontal, 12)
        }
    }
    
    private func FooterControls() -> some View {
        HStack {
            Button(action: audioManager.refreshApps) {
                Image(systemName: "arrow.clockwise")
            }
            Spacer()
            Text("v1.0.0").font(.caption)
        }
        .padding()
    }
}
