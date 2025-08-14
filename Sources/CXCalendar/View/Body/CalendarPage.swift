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
        LazyVGrid(columns: layout.columns, spacing: layout.vPadding) {
            ForEach(items) { item in
                compose.calendarItem(interval, item).erased
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
