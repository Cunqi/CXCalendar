//
//  CalendarMonthThumbnailView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/25/25.
//

import CXUICore
import SwiftUI

// MARK: - CalendarYearlyBodyContentView

struct CalendarYearlyBodyContentView: CXCalendarViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        VStack(spacing: layout.rowPadding) {
            if let bodyHeader = compose.bodyHeader {
                bodyHeader(month)
                    .erased
                    .maybe(context.calendarType.scrollBehavior == .scroll) {
                        $0.frame(height: layout.bodyHeaderHeight)
                    }
            }
            CalendarMonthThumbnailBodyView(
                monthInterval: manager.makeDateInterval(for: month, component: .month)
            )
        }
    }
}

// MARK: - CalendarYearlyBodyHeaderView

struct CalendarYearlyBodyHeaderView: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        Text(month, format: .dateTime.month())
            .font(.headline)
            .bold()
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, CXSpacing.oneX)
    }

    // MARK: Private

    private var foregroundColor: Color {
        isSameMonth ? theme.accentColor : .primary
    }

    private var isSameMonth: Bool {
        calendar.isSameMonthInYear(month, startDate)
    }
}

// MARK: - CalendarMonthThumbnailBodyView

struct CalendarMonthThumbnailBodyView: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let monthInterval: DateInterval

    var days: [IndexedDate] {
        context.calendar.makeFixedMonthGridDates(from: monthInterval)
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: layout.rowPadding) {
            ForEach(days) { day in
                CalendarMonthThumbnailDayView(day: day.value, dateInterval: monthInterval)
            }
        }
    }

    // MARK: Private

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 0),
        count: 7
    )
}

// MARK: - CalendarMonthThumbnailDayView

struct CalendarMonthThumbnailDayView: CXCalendarDayViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let day: Date

    let dateInterval: DateInterval

    var body: some View {
        Text(day.day)
            .font(.system(size: 8))
            .foregroundStyle(foregroundColor)
            .padding(CXSpacing.quarterX)
            .background {
                Circle()
                    .fill(backgroundColor)
            }
    }

    // MARK: Private

    private var foregroundColor: Color {
        if isInRange {
            return isStartDate ? .white : .primary
        }
        return .clear
    }

    private var backgroundColor: Color {
        isStartDate ? theme.accentColor : .clear
    }
}

#Preview {
    HStack {
        CalendarYearlyBodyContentView(month: .now)

        CalendarYearlyBodyContentView(month: Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: .now
        )!)
    }
    .padding(.horizontal)
    .environment(CXCalendarManager(context: .month(.page)))
}
