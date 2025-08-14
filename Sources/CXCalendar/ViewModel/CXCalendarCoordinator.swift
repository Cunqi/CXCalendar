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
public class CXCalendarCoordinator: CXTemplateDirectAccessible {
    // MARK: Lifecycle

    // MARK: - Initializer

    init(template: CXCalendarTemplate) {
        self.template = template
        selectedDate = template.core.selectedDate

        sizeCoordinator = CXCalendarSizeCoordinator(
            calendarMode: template.core.mode,
            itemLayoutStrategy: template.layout.itemLayoutStrategy,
            hPadding: template.layout.hPadding,
            vPadding: template.layout.vPadding
        )
    }

    // MARK: Public

    // MARK: - Public properties

    /// The calendar template containing the configuration and state of the calendar.
    public let template: CXCalendarTemplate

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
        switch core.mode {
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

    func dateInterval(for date: Date, _ mode: CXCalendarMode) -> DateInterval {
        core.calendar.dateInterval(of: mode.component, for: date)!
    }

    func items(
        for interval: DateInterval,
        _ mode: CXCalendarMode,
        _ scrollStrategy: CXCalendarScrollStrategy = .page
    ) -> [CXIndexedDate] {
        switch mode {
        case .year:
            yearlyItems(for: interval)
        case .month:
            monthlyItems(for: interval, scrollStrategy)
        case .week:
            weeklyItems(for: interval)
        }
    }

    // MARK: Private

    private func yearlyItems(for interval: DateInterval) -> [CXIndexedDate] {
        core.calendar.makeFixedYearGridDates(from: interval)
    }

    private func monthlyItems(
        for interval: DateInterval,
        _ scrollStrategy: CXCalendarScrollStrategy
    ) -> [CXIndexedDate] {
        switch scrollStrategy {
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
