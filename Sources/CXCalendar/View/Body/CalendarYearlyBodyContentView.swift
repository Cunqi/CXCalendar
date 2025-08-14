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
    @Environment(CXCalendarCoordinator.self) var coordinator

    let month: Date

    var body: some View {
        VStack(spacing: CXSpacing.halfX) {
            CalendarYearlyBodyHeaderView(month: month)
//            CalendarMonthThumbnailBodyView(
//                monthInterval: coordinator.makeDateInterval(for: month, component: .month)
//            )
        }
    }
}

// MARK: - CalendarYearlyBodyHeaderView

struct CalendarYearlyBodyHeaderView: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarCoordinator.self) var coordinator

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
        .primary
    }

    private var isSameMonth: Bool {
        calendar.isSameMonthInYear(month, startDate)
    }
}

// MARK: - CalendarMonthThumbnailBodyView

struct CalendarMonthThumbnailBodyView: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarCoordinator.self) var coordinator

    let monthInterval: DateInterval

    var days: [CXIndexedDate] {
        core.calendar.makeFixedMonthGridDates(from: monthInterval)
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: .zero) {
            ForEach(days) { day in
                CalendarMonthThumbnailDayView(date: day, dateInterval: monthInterval)
            }
        }
    }

    // MARK: Private

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: .zero),
        count: 7
    )
}

// MARK: - CalendarMonthThumbnailDayView

struct CalendarMonthThumbnailDayView: CXCalendarItemViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarCoordinator.self) var coordinator

    let date: CXIndexedDate

    let dateInterval: DateInterval

    var body: some View {
        Text(date.id.description)
            .font(.system(size: 8))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .ifElse(core.calendarType.scrollBehavior == .page) {
//                $0.aspectRatio(1, contentMode: .fit)
//            } else: {
//                $0.frame(height: CXSpacing.twoX)
//            }
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(foregroundColor)
            .background {
                if isStartDate {
                    Circle()
                }
            }
    }

    // MARK: Private

    private var foregroundColor: Color {
        if isInRange {
            return isStartDate ? .white : .primary
        }
        return .clear
    }
}

// #Preview {
//    HStack {
//        CalendarYearlyBodyContentView(month: .now)
//
//        CalendarYearlyBodyContentView(month: Calendar.current.date(
//            byAdding: .month,
//            value: 1,
//            to: .now
//        )!)
//    }
//    .padding(.horizontal)
//    .environment(CXCalendarCoordinator(context: .month(.page)))
// }
