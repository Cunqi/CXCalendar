//
//  File.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXUICore
import Observation
import SwiftUI

/// /// The `CXCalendarManager` class is responsible for managing the calendar's state and behavior.
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
        selectedDate = context.calendar.startOfDay(for: context.selectedDate)
        calendarType = context.calendarType
    }

    // MARK: Public

    // MARK: - Public properties

    /// The calendar context containing the configuration and state of the calendar.
    public let context: CXCalendarContext

    /// The start date of the calendar, representing the anchor date from which the calendar is displayed.
    public let startDate: Date

    /// The selected date of the calendar, which is the date currently highlighted or focused.
    public var selectedDate: Date

    /// The columns used for the calendar grid layout, typically representing the days of the week.
    public let columns: [GridItem]

    /// The current anchor date displayed in the calendar, calculated based on the current page offset.
    public var currentAnchorDate: Date {
        makeDate(for: currentPage)
    }

    /// The current date interval of the calendar, representing the range of dates currently displayed.
    public var currentDateInterval: DateInterval {
        makeDateInterval(for: currentPage)
    }

    // MARK: - Public Methods

    /// Determines whether the back to start button should be displayed for a given month.
    /// - This method checks if the given date is equal to start date with given granularities.
    ///  and whether the selected date is today.
    ///
    /// If the month is not the same as the start month and year, or if the selected date is not today,
    /// the button should be displayed.
    ///
    /// - Parameter date: The date to check, represented as a `Date`.
    /// - Returns: A Boolean value indicating whether the back to start button should be displayed.
    public func shouldBackToStart(date: Date) -> Bool {
        let isInRange: Bool = switch calendarType {
        case .year:
            context.calendar.isDate(date, equalTo: startDate, toGranularity: .year)
        case .month:
            context.calendar.isSameMonthInYear(date, startDate)
        case .week:
            context.calendar.isDate(date, equalTo: startDate, toGranularities: [.year, .weekOfYear])
        }
        let isTodaySelected = context.calendar.isSameDay(selectedDate, startDate)
        return !isInRange || !isTodaySelected
    }

    /// Resets the page to the start date and updates the selected date to the start date.
    public func backToStart() {
        currentPage = 0
        selectedDate = startDate
    }

    /// Toggles the presentation of the accessory view based on the calendar type.
    /// - For week view, the accessory view is always presented.
    /// - For month view with page scroll behavior, the accessory view is toggled.
    /// - For month view with scroll scroll behavior, the accessory view is never presented.
    public func togglePresentAccessoryView() {
        switch calendarType {
        case .week:
            shouldPresentAccessoryView = true
        case .month(.page):
            shouldPresentAccessoryView.toggle()
        case .month(.scroll):
            shouldPresentAccessoryView = false
        case .year:
            shouldPresentAccessoryView = false
        }
    }

    /// /// Enables or disables the presentation of the accessory view.
    /// - Parameter enabled: A Boolean value indicating whether the accessory view should be presented.
    public func enablePresentAccessoryView(_ enabled: Bool) {
        shouldPresentAccessoryView = enabled
    }

    // MARK: Internal

    var calendarType: CXCalendarType

    /// The current page offset in the calendar, used to determine which dates are displayed.
    var currentPage = 0

    /// Whether the accessory view should be presented.
    var shouldPresentAccessoryView = true

    func makeDateInterval(for date: Date) -> DateInterval {
        context.calendar.dateInterval(of: calendarType.component, for: date)!
    }

    func makeDays(from interval: DateInterval) -> [CXIndexedDate] {
        switch calendarType {
        case .year:
            []
        case .month:
            makeMonthGridDates(from: interval)
        case .week:
            makeWeekGridDates(from: interval)
        }
    }

    func makeDate(for offset: Int) -> Date {
        context.calendar.date(byAdding: calendarType.component, value: offset, to: startDate)!
    }

    func makeDateInterval(for offset: Int) -> DateInterval {
        context.calendar.dateInterval(
            of: calendarType.component,
            for: makeDate(for: offset)
        )!
    }

    func makeMonthGridDates(from monthInterval: DateInterval) -> [CXIndexedDate] {
        switch context.calendarType.scrollBehavior {
        case .page:
            context.calendar.makeFixedMonthGridDates(from: monthInterval)
        case .scroll:
            context.calendar.makeDynamicMonthGridDates(from: monthInterval)
        }
    }

    func makeWeekGridDates(from weekInterval: DateInterval) -> [CXIndexedDate] {
        context.calendar.makeFixedWeekGridDates(from: weekInterval)
    }

    func numberOfRows(for index: Int) -> Int {
        let date = makeDate(for: index)
        let numberOfWeeks = context.calendar.numberOfWeeks(inMonthOf: date)
        let hasBodyHeader = context.compose.bodyHeader != nil
        return numberOfWeeks + (hasBodyHeader ? 1 : 0)
    }

    func makeHeight(for index: Int) -> Int {
        switch calendarType {
        case .year(.scroll):
            let rowHeight = Int(context.layout.rowHeight)
            return rowHeight
        case .month(.scroll):
            let rowHeight = Int(context.layout.rowHeight)
            let rowPadding = Int(context.layout.rowPadding)
            let numberOfRows = numberOfRows(for: index)
            return numberOfRows * (rowHeight + rowPadding) - rowPadding
        default:
            return 0
        }
    }

    func shouldPresentAccessoryView(for date: Date) -> Bool {
        switch calendarType {
        case .week:
            true
        case .month(.page):
            shouldPresentAccessoryView && context.calendar.isSameDay(date, currentAnchorDate)
        case .month(.scroll):
            false
        case .year:
            false
        }
    }
}
