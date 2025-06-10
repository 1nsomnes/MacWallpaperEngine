//
//  MacWallpaperEngineApp.swift
//  MacWallpaperEngine
//
//  Created by Cedric Claessens on 6/9/25.
//

import SwiftUI
import AVKit
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        
    }
    
    func applicationDidUpdate(_ notification: Notification) {
        print(NSApp.windows)
        
        if let ws = NSApp.windows.first(where: {
            $0.identifier?.rawValue == "wallpaper"
        }) {
            doSetup(on: ws)
        }
    }
    
    
    
    private func doSetup(on window: NSWindow) {
        print("made it here")
        window.standardWindowButton(.closeButton)?.isHidden = true;
        window.standardWindowButton(.zoomButton)?.isHidden = true;
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true;
        
        let desktopLevel = CGWindowLevelForKey(.desktopWindow)
        window.level = .init(rawValue: Int(desktopLevel))
        
        window.collectionBehavior = [
                .canJoinAllSpaces,
                .stationary,           // doesn’t move with full-screen apps
                .ignoresCycle,          // Cmd+` won’t bring it forward
                .fullScreenAuxiliary
            ]
        
        window.ignoresMouseEvents = true
        
        window.isOpaque = false
        window.backgroundColor = .clear
        window.styleMask = [.borderless]
        window.hasShadow = false
        
        if let screen = window.screen ?? NSScreen.main {
            window.setFrame(screen.frame, display: true)
          }
        window.orderFrontRegardless()
        
        //window.setFrame(fullFrame, display: true, animate: false)
        
      }
}

@main
struct MacWallpaperEngineApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.openWindow) private var openWindow
    
    var body: some Scene {
        MenuBarExtra("Utility", systemImage: "hammer") {
            
            Button("Open Wallpaper") {
                openWindow(id:"wallpaper")
            }
            
        }
        Window("wallpaper", id: "wallpaper") {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        
    }
 }
 
