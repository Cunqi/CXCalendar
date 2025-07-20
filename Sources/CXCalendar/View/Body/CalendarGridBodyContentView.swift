//
//  CalendarGridBodyContentView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXFoundation
import SwiftUI

struct CalendarGridBodyContentView: CXCalendarBodyContentViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let date: Date

    var body: some View {
        LazyVGrid(columns: manager.columns, spacing: layout.rowPadding) {
            ForEach(days) { day in
                compose.dayView(dateInterval, day.value).erased
            }
        }
        .onChange(of: manager.currentPage) { oldValue, newValue in
            let isIncrement = newValue > oldValue
            if case .week = calendarType, !dateInterval.containsDay(
                selectedDate,
                calendar: calendar
            ) {
                manager.selectedDate = isIncrement
                    ? dateInterval.start
                    : dateInterval
                        .lastDay(calendar: calendar)
            }
        }
    }

    var dateInterval: DateInterval {
        manager.makeDateInterval(for: date)
    }

    var days: [IdentifiableDate] {
        manager.makeDays(from: dateInterval)
    }
}
