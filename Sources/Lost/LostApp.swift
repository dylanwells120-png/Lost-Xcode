import SwiftUI

@main
struct LostApp: App {
    var body: some Scene {
        WindowGroup("Lost") {
            GameView()
                .frame(minWidth: 960, minHeight: 540)
        }
    }
}
