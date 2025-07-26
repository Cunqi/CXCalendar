//
//  CalendarMonthThumbnailView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/25/25.
//

import CXUICore
import SwiftUI

// MARK: - CalendarMonthThumbnailView

struct CalendarYearlyBodyContentView: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var isSameMonth: Bool {
        calendar.isSameMonthInYear(month, startDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: CXSpacing.halfX) {
            monthText
                .padding(.horizontal, CXSpacing.oneX)
            CalendarMonthThumbnailBodyView(monthInterval: manager.makeDateInterval(for: month))
        }
    }

    // MARK: Private

    private var monthText: some View {
        Text(month, format: .dateTime.month())
            .font(.headline)
            .bold()
            .foregroundStyle(foregroundColor)
    }

    private var foregroundColor: Color {
        isSameMonth ? theme.accentColor : .primary
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
        LazyVGrid(columns: columns, spacing: CXSpacing.halfX) {
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
    @Environment(CXCalendarManager.self) var manager

    let day: Date

    let dateInterval: DateInterval

    var body: some View {
        Text(day.day)
            .font(.caption2)
            .foregroundStyle(foregroundColor)
            .padding(CXSpacing.quarterX)
            .background {
                Circle()
                    .fill(backgroundColor)
            }
    }

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

        CalendarYearlyBodyContentView(month: Calendar.current.date(byAdding: .month, value: 1, to: .now)!)
    }
    .padding(.horizontal)
    .environment(CXCalendarManager(context: .month(.page)))
}
