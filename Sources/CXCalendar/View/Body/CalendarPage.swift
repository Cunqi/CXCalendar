//
//  CalendarPage.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/14/25.
//

import SwiftUI

struct CalendarPage: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarCoordinator.self) var coordinator: CXCalendarCoordinator

    let date: Date

    var body: some View {
        VStack(spacing: layout.vPadding) {
            if core.scrollStrategy == .scroll {
                compose.calendarPageHeader(date).erased
            }

            LazyVGrid(columns: layout.columns, spacing: layout.vPadding) {
                ForEach(items) { item in
                    compose.calendarItem(interval, item).erased
                }
            }

            if let accessoryView = compose.accessoryView,
               core.scrollStrategy == .page,
               layout.itemLayoutStrategy != .flexHeight {
                accessoryView(selectedDate, interval)
                    .erased
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
            }
        }
    }

    // MARK: Private

    private var interval: DateInterval {
        coordinator.dateInterval(for: date, core.mode)
    }

    private var items: [CXIndexedDate] {
        coordinator.items(for: interval, core.mode, core.scrollStrategy)
    }
}
