import AVFoundation
import AppKit
import SwiftUI

@main
struct UselessOiiaiCatApp: App {
    var body: some Scene {
        WindowGroup {
            CatView()
                .frame(width: 420, height: 420)
        }
        .windowResizability(.contentSize)
    }
}

struct CatView: View {
    @StateObject private var audio = OiiaiAudioLoop()

    var body: some View {
        AssetCatGIFView()
            .frame(width: 360, height: 360)
            .background(.clear)
            .onAppear {
                audio.play()
            }
            .onDisappear {
                audio.stop()
            }
    }
}

@MainActor
final class OiiaiAudioLoop: ObservableObject {
    private var player: AVAudioPlayer?

    init() {
        guard let url = Bundle.module.urls(forResourcesWithExtension: "mp3", subdirectory: "assets")?.first else {
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.volume = 0.9
            player.prepareToPlay()
            self.player = player
        } catch {
            self.player = nil
        }
    }

    func play() {
        player?.play()
    }

    func stop() {
        player?.stop()
        player?.currentTime = 0
    }
}

struct AssetCatGIFView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSImageView {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.imageAlignment = .alignCenter

        if let url = Bundle.module.url(forResource: "oiiai-transparent", withExtension: "gif", subdirectory: "assets") {
            imageView.image = NSImage(contentsOf: url)
            imageView.animates = true
        }

        return imageView
    }

    func updateNSView(_ imageView: NSImageView, context: Context) {
        imageView.animates = true
    }
}
