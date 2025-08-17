import CXLazyPage
import SwiftUI

// MARK: - PageCalendarContainer

struct PageCalendarContainer: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(\.orientation) var orientation
    @Binding var coordinator: CXCalendarCoordinator

    var body: some View {
        switch layout.layoutStrategy {
        case .equalWidth, .fixedHeight:
            if orientation.isLandscape {
                flexHeightContainer
            } else {
                fixedHeightContainer
            }

        default:
            flexHeightContainer
        }
    }

    // MARK: Private

    @ViewBuilder
    private var accessoryView: some View {
        if let accessoryView = compose.accessoryView {
            accessoryView(coordinator.selectedDate)
                .erased
                .onChange(of: coordinator.anchorDate) { _, _ in
                    coordinator.selectFirstDateAfterAnchorDateChange()
                }
        }
    }

    private var calendarHeader: some View {
        Group {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(anchorDate).erased
            } else {
                Color.clear
                    .frame(height: .zero)
            }
        }
    }

    private var calendarBody: some View {
        CXInfinityPage(
            axis: layout.axis,
            currentPage: $coordinator.currentPage,
            scrollEnabled: $coordinator.scrollEnabled
        ) { } page: {
            CalendarPage(date: coordinator.date(at: $0))
        }
    }

    @ViewBuilder
    private var fixedHeightContainer: some View {
        VStack(spacing: .zero) {
            calendarHeader
            calendarBody
                .frame(
                    height: coordinator.sizeProvider.calendarHeight
                )
                .onDimensionChange {
                    coordinator.sizeProvider.calculateHeightForFixedHeightItem(with: $0)
                }
            accessoryView
        }
        .environment(coordinator)
        .maybe(compose.accessoryView != nil) {
            $0.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }

    @ViewBuilder
    private var flexHeightContainer: some View {
        GeometryReader { proxy in
            VStack(spacing: .zero) {
                calendarHeader
                    .onDimensionChange {
                        coordinator.sizeProvider.calculateHeightForFlexHeightItem(
                            with: proxy.size,
                            usedHeight: $0.size.height
                        )
                    }
                calendarBody
                    .frame(
                        width: proxy.size.width,
                        height: coordinator.sizeProvider.calendarHeight
                    )
            }
        }
        .environment(coordinator)
    }
}
