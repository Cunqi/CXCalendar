//
//  CXCalendarContext.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

/// Context object containing layout, appearance, and behavioral information for a calendar view. Use in conjunction with CXCalendar for customization.

import CXUICore
import SwiftUI

/// Encapsulates configuration for a calendar's layout, appearance, and user interaction.
public struct CXCalendarContext {
    /// Orientation of the calendar axis (horizontal or vertical).
    public let axis: Axis

    /// Padding between each column of days.
    public let columnPadding: CGFloat

    /// Padding between each row of days.
    public let rowPadding: CGFloat

    /// Calendar used for all date and calculation logic.
    public let calendar: Calendar

    /// Titles representing the days of the week.
    public let weekdayTitles: [String]

    /// The calendar's starting display date.
    public let startDate: Date

    /// The date initially selected by the calendar, if any.
    public let selectedDate: Date?

    /// Closure returning a SwiftUI View for the month header, given the current month date.
    public let headerView: (Date) -> any View

    /// Closure returning a SwiftUI View for individual days, given the month and day dates.
    public let dayView: (Date, Date) -> any View

    /// Closure to tell if given date can be selected
    public let canSelect: (Date, Date, Calendar) -> Bool

    /// Closure to tell if given date is selected
    public let isSelected: (Date, Date?, Calendar) -> Bool

    /// Callback triggered when a date is selected or deselected.
    public let onSelected: ((Date?) -> Void)?

    /// Callback triggered when the month is changed.
    public let onMonthChanged: ((Date) -> Void)?

    /// Optional closure returning a SwiftUI View to overlay when a day is selected.
    public let accessoryView: ((Date) -> any View)?
}

// Builder

public extension CXCalendarContext {
    /// Builder for configuring CXCalendarContext properties incrementally.
    class Builder {
        private var columnPadding: CGFloat = CXSpacing.oneX
        private var rowPadding: CGFloat = CXSpacing.oneX
        private var axis: Axis = .horizontal

        private var calendar: Calendar = .current
        private var startDate: Date = .now
        private var selectedDate: Date?

        private var weekdayTitles: [String] = Calendar.current.veryShortWeekdaySymbols

        private var headerView: (Date) -> any CXMonthHeaderViewRepresentable = { month in
            MonthHeaderView(month: month)
        }

        private var dayView: (Date, Date) -> any CXDayViewRepresentable = { month, day in
            DayView(month: month, day: day)
        }

        private var canSelect: (Date, Date, Calendar) -> Bool = { _, _, _ in true }

        private var isSelected: (Date, Date?, Calendar) -> Bool = { day, selectedDate, calendar in
            selectedDate.map { calendar.isDate(day, inSameDayAs: $0) } ?? false
        }

        private var onSelected: ((Date?) -> Void)?

        private var onMonthChanged: ((Date) -> Void)?

        private var accessoryView: ((Date) -> any View)?

        // MARK: - Initializer

        public init() {}

        // MARK: - Public methods

        /// Sets the orientation axis for the calendar layout.
        public func axis(_ axis: Axis) -> Builder {
            self.axis = axis
            return self
        }

        /// Sets the padding between columns of days.
        public func columnPadding(_ columnPadding: CGFloat) -> Builder {
            self.columnPadding = columnPadding
            return self
        }

        /// Sets the padding between rows of days.
        public func rowPadding(_ rowPadding: CGFloat) -> Builder {
            self.rowPadding = rowPadding
            return self
        }

        /// Sets the calendar used for date calculations.
        public func calendar(_ calendar: Calendar) -> Builder {
            self.calendar = calendar
            return self
        }

        /// Sets the start date of the calendar display.
        public func startDate(_ startDate: Date) -> Builder {
            self.startDate = startDate
            return self
        }

        /// Sets the initially selected date.
        public func selectedDate(_ selectedDate: Date) -> Builder {
            self.selectedDate = selectedDate
            return self
        }

        /// Sets the titles for the weekdays.
        public func weekdayTitles(_ weekdayTitles: [String]) -> Builder {
            self.weekdayTitles = weekdayTitles
            return self
        }

        /// Sets the header view closure for the month header.
        public func headerView(_ headerView: @escaping (Date) -> some CXMonthHeaderViewRepresentable) -> Builder {
            self.headerView = headerView
            return self
        }

        /// Sets the day view closure for individual day cells.
        public func dayView(_ dayView: @escaping (Date, Date) -> some CXDayViewRepresentable) -> Builder {
            self.dayView = dayView
            return self
        }

        /// Sets the canSelect closure for individual day cells.
        public func canSelect(_ canSelect: @escaping (Date, Date, Calendar) -> Bool) -> Builder {
            self.canSelect = canSelect
            return self
        }

        /// Sets the isSelected closure for individual day cells.
        public func isSelected(_ isSelected: @escaping (Date, Date?, Calendar) -> Bool) -> Builder {
            self.isSelected = isSelected
            return self
        }

        /// Sets the callback for when a date is selected or deselected.
        public func onSelected(_ onSelected: @escaping (Date?) -> Void) -> Builder {
            self.onSelected = onSelected
            return self
        }

        /// Sets the callback for when the month is changed.
        public func onMonthChanged(_ onMonthChanged: @escaping (Date) -> Void) -> Builder {
            self.onMonthChanged = onMonthChanged
            return self
        }

        /// Sets the accessory view closure displayed when a date is selected.
        public func accessoryView(_ accessoryView: @escaping (Date) -> some View) -> Builder {
            self.accessoryView = accessoryView
            return self
        }

        /// Produces a fully configured CXCalendarContext with the given properties.
        public func build() -> CXCalendarContext {
            return CXCalendarContext(
                axis: axis,
                columnPadding: columnPadding,
                rowPadding: rowPadding,
                calendar: calendar,
                weekdayTitles: weekdayTitles,
                startDate: startDate,
                selectedDate: selectedDate,
                headerView: headerView,
                dayView: dayView,
                canSelect: canSelect,
                isSelected: isSelected,
                onSelected: onSelected,
                onMonthChanged: onMonthChanged,
                accessoryView: accessoryView
            )
        }
    }
}

public extension CXCalendarContext {
    /// Returns a default CXCalendarContext instance with standard configuration.
    static var standard: CXCalendarContext {
        CXCalendarContext.Builder().build()
    }
}
