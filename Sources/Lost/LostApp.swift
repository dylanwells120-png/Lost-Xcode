import AppKit
import SwiftUI

/// A SwiftPM executable launches as a background process by default; make it a normal
/// foreground app so the window appears and receives keyboard input.
final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }
}

@main
struct LostApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup("Lost") {
            GameView()
                .frame(minWidth: 960, minHeight: 540)
        }
    }
}
