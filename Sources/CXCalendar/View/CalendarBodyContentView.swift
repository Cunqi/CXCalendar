//
//  CalendarBodyContentView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXFoundation
import SwiftUI

struct CalendarBodyContentView: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let date: Date

    var body: some View {
        LazyVGrid(columns: manager.columns, spacing: layout.rowPadding) {
            ForEach(days) { day in
                compose.dayView(dateInterval, day.value).erased
            }
        }
    }

    // MARK: Private

    private var dateInterval: DateInterval {
        manager.makeDateInterval(for: date)
    }

    private var days: [IdentifiableDate] {
        manager.makeBodyGridDates(from: dateInterval)
    }
}

