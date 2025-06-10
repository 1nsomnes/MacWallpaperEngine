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
    let player = AVPlayer(url: URL(string:
      "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_5MB.mp4"
    )!)

    var body: some View {
        NoControlsPlayerView(player: player)
          .ignoresSafeArea()
          .onAppear { player.play() }
          .navigationTitle("balls")
    }
}
