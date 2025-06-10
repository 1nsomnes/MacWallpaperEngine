import SwiftUI
import AVKit

struct NoControlsPlayerView: NSViewRepresentable {
    let player: AVPlayer

    func makeNSView(context: Context) -> AVPlayerView {
        let playerView = AVPlayerView()
        playerView.player = player
        playerView.controlsStyle = .none       // ← hides seek bar, play/pause, etc.
        playerView.videoGravity = .resizeAspectFill
        return playerView
    }

    func updateNSView(_ nsView: AVPlayerView, context: Context) {
        // nothing to update
    }
}

struct ContentView: View {
    //let fileURL = URL(fileURLWithPath: "/Users/ced/Downloads/wallpaper.mp4")
    let player = AVPlayer(url: URL(fileURLWithPath: "/Users/ced/Downloads/wallpaper.mp4"))
    

    var body: some View {
        //AsyncImage(url: URL(string: "https://512pixels.net/downloads/macos-wallpapers-6k/10-6-6k.jpg"))
        NoControlsPlayerView(player: player)
          .ignoresSafeArea()
          .onAppear {
              player.play()
              
              NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: nil,
                            queue: nil
                          ) { _ in
                              player.seek(to: CMTime.zero)
                            player.play()
                          }
              
          }
    }
}
