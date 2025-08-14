//
//  CXCalendarCoordinator.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXUICore
import Observation
import SwiftUI

/// The `CXCalendarCoordinator` class is responsible for managing the calendar's state and behavior.
@MainActor
@Observable
public class CXCalendarCoordinator: CXContextAccessible {
    // MARK: Lifecycle

    // MARK: - Initializer

    init(context: CXCalendarContext) {
        self.context = context
        selectedDate = context.core.selectedDate

        sizeCoordinator = CXCalendarSizeCoordinator(
            calendarMode: context.core.mode,
            itemLayoutStrategy: context.layout.itemLayoutStrategy,
            hPadding: context.layout.hPadding,
            vPadding: context.layout.vPadding
        )
    }

    // MARK: Public

    // MARK: - Public properties

    /// The calendar context containing the configuration and state of the calendar.
    public let context: CXCalendarContext

    /// The size coordinator used to calculate the size of the calendar.
    public let sizeCoordinator: CXCalendarSizeCoordinator

    /// The selected date of the calendar, which is the date currently highlighted or focused.
    public var selectedDate: Date

    /// The current anchor date displayed in the calendar, calculated based on the current page offset.
    public var currentAnchorDate: Date {
        date(at: currentPage)
    }

    /// Determines whether the calendar has changed. A calendar is considered changed if:
    /// - For year: the currentPage is not 0
    /// - For month: the currentPage is not 0 or the selectedDate is not the start date
    /// - For week: the currentPage is not 0 or the selectedDate is not the start date

    public var isCalendarChanged: Bool {
        let isCurrentPageChanged = currentPage != 0
        let isSelectedDateChanged = core.calendar.isSameDay(selectedDate, core.startDate)
        switch core.calendarType {
        case .year:
            return isCurrentPageChanged
        case .month, .week:
            return isCurrentPageChanged || !isSelectedDateChanged
        }
    }

    // MARK: - Public Methods

    /// Resets the page to the start date and updates the selected date to the start date.
    public func reset() {
        selectedDate = core.startDate
        currentPage = Int.zero
    }

    /// Sets whether the calendar is scrollable.
    /// - Parameter enabled: A Boolean value that indicates whether the calendar is scrollable.
    public func setScrollEnabled(_ enabled: Bool) {
        scrollEnabled = enabled
    }

    public func scroll(to date: Date) {
        let distance = core.calendar.dateComponents(
            [core.mode.component],
            from: core.startDate,
            to: date
        )
        currentPage = distance.value(for: core.mode.component) ?? .zero
    }

    // MARK: Internal

    /// Determines whether the calendar is scrollable.
    var scrollEnabled = true

    /// The current page offset in the calendar, used to determine which dates are displayed.
    var currentPage = Int.zero

    func date(at index: Int) -> Date {
        core.calendar.date(
            byAdding: core.mode.component,
            value: index,
            to: core.startDate
        )!
    }

    func dateInterval(at index: Int) -> DateInterval {
        dateInterval(for: date(at: index))
    }

    func dateInterval(for date: Date) -> DateInterval {
        core.calendar.dateInterval(of: core.calendarType.component, for: date)!
    }

    func items(for interval: DateInterval) -> [CXIndexedDate] {
        switch core.mode {
        case .year:
            yearlyItems(for: interval)
        case .month:
            monthlyItems(for: interval)
        case .week:
            weeklyItems(for: interval)
        }
    }

    // MARK: Private

    private func yearlyItems(for interval: DateInterval) -> [CXIndexedDate] {
        core.calendar.makeFixedYearGridDates(from: interval)
    }

    private func monthlyItems(for interval: DateInterval) -> [CXIndexedDate] {
        switch core.scrollStrategy {
        case .page:
            core.calendar.makeFixedMonthGridDates(from: interval)
        case .scroll:
            core.calendar.makeDynamicMonthGridDates(from: interval)
        }
    }

    private func weeklyItems(for interval: DateInterval) -> [CXIndexedDate] {
        core.calendar.makeFixedWeekGridDates(from: interval)
    }
}
