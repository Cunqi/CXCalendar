import SwiftUI

extension EnvironmentValues {
    @Entry var orientation = UIDeviceOrientation.unknown
}

struct OrientationReader: ViewModifier {
    @State private var orientation = UIDevice.current.orientation
    private let publisher = NotificationCenter.default
        .publisher(for: UIDevice.orientationDidChangeNotification)

    func body(content: Content) -> some View {
        content
            .environment(\.orientation, orientation)
            .onReceive(publisher) { _ in
                let newValue = UIDevice.current.orientation
                if newValue != .unknown, newValue != .faceUp, newValue != .faceDown {
                    orientation = newValue
                }
            }
    }
}

extension View {
    func withOrientation() -> some View {
        modifier(OrientationReader())
    }
}
