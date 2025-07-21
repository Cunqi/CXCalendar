//
//  CalendarBodyContentView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXUICore
import SwiftUI

/// This view is responsible for rendering the content of the calendar body.
/// It displays the days of the month or week, depending on the calendar type.
struct CalendarBodyContentView: CXCalendarBodyContentViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let date: Date

    var body: some View {
        LazyVGrid(columns: manager.columns, spacing: layout.rowPadding) {
            ForEach(days) { day in
                compose.dayView(dateInterval, day.value, namespace).erased
            }
        }
        .onChange(of: manager.currentPage) { oldValue, newValue in
            // For weekly calendar, if selected date is not in current week interval,
            // select start or last day as the initial selected date.
            // if selected date equals to start date. means it is a reset, do nothing.
            if case .week = calendarType,
               !dateInterval.containsDay(selectedDate, calendar: calendar),
               !calendar.isSameDay(selectedDate, startDate) {
                manager.selectedDate = newValue > oldValue
                    ? dateInterval.start
                    : dateInterval.lastDay(calendar: calendar)
            }
        }
    }

    var dateInterval: DateInterval {
        manager.makeDateInterval(for: date)
    }

    var days: [IdentifiableDate] {
        manager.makeDays(from: dateInterval)
    }

    // MARK: Private

    @Namespace private var namespace
}
