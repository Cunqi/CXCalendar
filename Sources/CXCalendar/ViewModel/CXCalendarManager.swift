//
//  File.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import Observation
import SwiftUI

@Observable
@MainActor
public class CXCalendarManager {
    // MARK: Lifecycle

    // MARK: - Initializer

    init(context: CXCalendarContext) {
        self.context = context

        columns = Array(
            repeating: GridItem(.flexible(), spacing: context.layout.columnPadding),
            count: 7
        )

        startDate = context.calendar.startOfDay(for: context.startDate)
        selectedDate = context.selectedDate
        calendarType = context.calendarType
    }

    // MARK: Public

    // MARK: - Public properties

    public let context: CXCalendarContext

    public let startDate: Date

    public var selectedDate: Date

    public let columns: [GridItem]

    public var currentDate: Date {
        makeDate(for: currentPage)
    }

    public var currentDateInterval: DateInterval {
        makeDateInterval(for: currentPage)
    }

    // MARK: - Public Methods

    /// Determines whether the reset to today button should be displayed for a given month.
    /// - This method checks if the given month has the same month and year as the start date,
    ///  and whether the selected date is today.
    ///
    /// If the month is not the same as the start month and year, or if the selected date is not today,
    /// the button should be displayed.
    ///
    /// - Parameter date: The date to check, represented as a `Date`.
    /// - Returns: A Boolean value indicating whether the reset to today button should be displayed.
    public func shouldDisplayResetToTodayButton(date: Date) -> Bool {
        let isInRange: Bool = switch calendarType {
        case .month:
            context.calendar.isSameMonthInYear(date, startDate)
        case .week:
            context.calendar.isDate(date, equalTo: startDate, toGranularities: [.year, .weekOfYear])
        }
        let isTodaySelected = context.calendar.isSameDay(selectedDate, startDate)
        return !isInRange || !isTodaySelected
    }

    public func resetToToday() {
        currentPage = 0
        selectedDate = startDate
    }

    // MARK: Internal

    var calendarType: CXCalendarType

    var currentPage = 0

    var presentAccessoryView = false

    func makeDateInterval(for date: Date) -> DateInterval {
        context.calendar.dateInterval(of: calendarType.component, for: date)!
    }

    func makeDays(from interval: DateInterval) -> [IdentifiableDate] {
        switch calendarType {
        case .month:
            makeMonthGridDates(from: interval)
        case .week:
            makeWeekGridDates(from: interval)
        }
    }

    // MARK: - Internal Methods

    func makeDate(for offset: Int) -> Date {
        context.calendar.date(byAdding: calendarType.component, value: offset, to: startDate)!
    }

    func makeDateInterval(for offset: Int) -> DateInterval {
        context.calendar.dateInterval(
            of: calendarType.component,
            for: makeDate(for: offset)
        )!
    }

    func makeMonthGridDates(from monthInterval: DateInterval) -> [IdentifiableDate] {
        switch context.calendarType.scrollBehavior {
        case .page:
            context.calendar.makeFixedMonthGridDates(from: monthInterval)
        case .scroll:
            context.calendar.makeDynamicMonthGridDates(from: monthInterval)
        }
    }

    func makeWeekGridDates(from weekInterval: DateInterval) -> [IdentifiableDate] {
        context.calendar.makeFixedWeekGridDates(from: weekInterval)
    }

    func numberOfRows(for index: Int) -> Int {
        context.calendar.numberOfWeeks(inMonthOf: makeDate(for: index)) + 1 // +1 for month header
    }
}
