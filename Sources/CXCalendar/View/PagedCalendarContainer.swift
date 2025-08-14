//
//  PagedCalendarContainer.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXLazyPage
import CXUICore
import SwiftUI

// MARK: - PagedCalendarContainer

/// This view represents a paged calendar that allows users to navigate through dates in a paginated manner.
struct PagedCalendarContainer: CXCalendarViewRepresentable {
    @Binding var coordinator: CXCalendarCoordinator

    var body: some View {
        let _ = Self._printChanges()
        VStack(spacing: layout.vPadding) {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(currentAnchorDate).erased
            }

            GeometryReader { proxy in
                CXInfinityPage(
                    axis: layout.axis,
                    currentPage: $coordinator.currentPage,
                    scrollEnabled: $coordinator.scrollEnabled
                ) { index in
                    CalendarPage(date: coordinator.date(at: index))
                }
                .frame(
                    width: proxy.size.width,
                    height: coordinator.sizeCoordinator.calendarHeight
                )
                .onAppear {
                    coordinator.sizeCoordinator
                        .calculateHeightForPageStrategy(with: proxy.size)
                }
            }
        }
        .environment(coordinator)
    }
}

// MARK: - CalendarPage

private struct CalendarPage: CXCalendarViewRepresentable {
    @Environment(CXCalendarCoordinator.self) var coordinator: CXCalendarCoordinator

    let date: Date

    private var interval: DateInterval {
        coordinator.dateInterval(for: date)
    }

    private var items: [CXIndexedDate] {
        coordinator.items(for: interval)
    }

    var body: some View {
        LazyVGrid(columns: layout.columns, spacing: layout.vPadding) {
            ForEach(items) { item in
                compose.calendarItem(interval, item).erased
            }
        }
    }
}
