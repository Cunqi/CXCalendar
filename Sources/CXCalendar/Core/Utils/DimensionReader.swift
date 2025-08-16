import SwiftUI

// MARK: - Dimension

struct Dimension: Equatable {
    let size: CGSize
    let safeAreaInsets: EdgeInsets

    static var zero: Dimension {
        Dimension(size: .zero, safeAreaInsets: EdgeInsets())
    }
}

// MARK: - DimensionKey

private struct DimensionKey: PreferenceKey {
    static var defaultValue: Dimension {
        .zero
    }

    static func reduce(value: inout Dimension, nextValue: () -> Dimension) {
        let next = nextValue()
        if next != .zero {
            value = next
        }
    }
}

// MARK: - DimensionReader

struct DimensionReader: View {
    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: DimensionKey.self,
                    value: Dimension(
                        size: proxy.size,
                        safeAreaInsets: proxy.safeAreaInsets
                    )
                )
        }
    }
}

extension View {
    func onDimensionChange(_ perform: @escaping (Dimension) -> Void) -> some View {
        background(
            DimensionReader()
        )
        .onPreferenceChange(DimensionKey.self, perform: perform)
    }
}
