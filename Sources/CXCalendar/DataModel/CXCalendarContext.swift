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

    /// Height of each row of month view. it is only used for scrollable calendar.
    public let rowHeight: CGFloat

    /// Calendar used for all date and calculation logic.
    public let calendar: Calendar

    /// Titles representing the days of the week.
    public let weekdayTitles: [String]

    /// The calendar's starting display date.
    public let startDate: Date

    /// The date initially selected by the calendar, if any.
    public let selectedDate: Date?

    /// Closure returning a SwiftUI View for the calendar header, given the current month date.
    public let calendarHeader: (Date) -> any CXCalendarHeaderViewRepresentable

    /// Closure returning a SwiftUI View for the month header, given the current month date.
    /// This is used to display the month title along with the month view.
    public let monthHeader: ((Date) -> any CXCalendarHeaderViewRepresentable)?

    /// Closure returning a SwiftUI View for individual days, given the month and day dates.
    public let dayView: (Date, Date) -> any CXDayViewRepresentable

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

    // MARK: - Internal properties

    /// Style of the calendar (paged or scrollable)
    let style: CalendarStyle

    /// Flag indicating whether to ignore days that are not in the current month.
    let shouldIgnoreNonCurrentMonthDays: Bool

    // MARK: - Initializer

    init(axis: Axis,
         columnPadding: CGFloat,
         rowPadding: CGFloat,
         rowHeight: CGFloat,
         style: CalendarStyle,
         calendar: Calendar,
         weekdayTitles: [String],
         startDate: Date,
         selectedDate: Date?,
         calendarHeader: @escaping (Date) -> any CXCalendarHeaderViewRepresentable,
         monthHeader: ((Date) -> any CXCalendarHeaderViewRepresentable)?,
         dayView: @escaping (Date, Date) -> any CXDayViewRepresentable,
         canSelect: @escaping (Date, Date, Calendar) -> Bool,
         isSelected: @escaping (Date, Date?, Calendar) -> Bool,
         onSelected: ((Date?) -> Void)?,
         onMonthChanged: ((Date) -> Void)?,
         accessoryView: ((Date) -> any View)?,
         shouldIgnoreNonCurrentMonthDays: Bool)
    {
        self.axis = axis
        self.columnPadding = columnPadding
        self.rowPadding = rowPadding
        self.rowHeight = rowHeight
        self.style = style
        self.calendar = calendar
        self.weekdayTitles = weekdayTitles
        self.startDate = startDate
        self.selectedDate = selectedDate
        self.calendarHeader = calendarHeader
        self.monthHeader = monthHeader
        self.dayView = dayView
        self.canSelect = canSelect
        self.isSelected = isSelected
        self.onSelected = onSelected
        self.onMonthChanged = onMonthChanged
        self.accessoryView = accessoryView
        self.shouldIgnoreNonCurrentMonthDays = shouldIgnoreNonCurrentMonthDays
    }
}

// Builder

public extension CXCalendarContext {
    /// Builder for configuring CXCalendarContext properties incrementally.
    class Builder {
        private var columnPadding: CGFloat = CXSpacing.oneX
        private var rowPadding: CGFloat = CXSpacing.oneX
        private var rowHeight: CGFloat = CXSpacing.sixX
        private var axis: Axis = .horizontal
        private var style: CalendarStyle = .paged

        private var calendar: Calendar = .current
        private var startDate: Date = .now
        private var selectedDate: Date?

        private var weekdayTitles: [String] = Calendar.current.veryShortWeekdaySymbols

        private var calendarHeader: (Date) -> any CXCalendarHeaderViewRepresentable = { month in
            CalendarHeaderView(month: month)
        }

        private var monthHeader: ((Date) -> any CXCalendarHeaderViewRepresentable)?

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

        private var shouldIgnoreNonCurrentMonthDays: Bool = false

        // MARK: - Initializer

        init() {}

        init(with context: CXCalendarContext) {
            axis = context.axis
            columnPadding = context.columnPadding
            rowPadding = context.rowPadding
            rowHeight = context.rowHeight
            calendar = context.calendar
            weekdayTitles = context.weekdayTitles
            startDate = context.startDate
            selectedDate = context.selectedDate
            calendarHeader = context.calendarHeader
            monthHeader = context.monthHeader
            dayView = context.dayView
            canSelect = context.canSelect
            isSelected = context.isSelected
            onSelected = context.onSelected
            onMonthChanged = context.onMonthChanged
            accessoryView = context.accessoryView
            shouldIgnoreNonCurrentMonthDays = context.shouldIgnoreNonCurrentMonthDays
            style = context.style
        }

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

        /// Sets the height of each row of month view. it is only used for scrollable calendar.
        public func rowHeight(_ rowHeight: CGFloat) -> Builder {
            self.rowHeight = rowHeight
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

        /// Sets the calendar header view closure for the calendar.
        public func calendarHeader(_ calendarHeader: @escaping (Date) -> some CXCalendarHeaderViewRepresentable) -> Builder {
            self.calendarHeader = calendarHeader
            return self
        }

        /// Sets the month header view closure for the month header.
        public func monthHeader(_ monthHeader: ((Date) -> any CXCalendarHeaderViewRepresentable)?) -> Builder {
            self.monthHeader = monthHeader
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

        // MARK: - Internal methods

        func shouldIgnoreNonCurrentMonthDays(_ shouldIgnoreNonCurrentMonthDays: Bool) -> Builder {
            self.shouldIgnoreNonCurrentMonthDays = shouldIgnoreNonCurrentMonthDays
            return self
        }

        func style(_ style: CalendarStyle) -> Builder {
            self.style = style
            return self
        }

        /// Produces a fully configured CXCalendarContext with the given properties.
        public func build() -> CXCalendarContext {
            return CXCalendarContext(
                axis: axis,
                columnPadding: columnPadding,
                rowPadding: rowPadding,
                rowHeight: rowHeight,
                style: style,
                calendar: calendar,
                weekdayTitles: weekdayTitles,
                startDate: startDate,
                selectedDate: selectedDate,
                calendarHeader: calendarHeader,
                monthHeader: monthHeader,
                dayView: dayView,
                canSelect: canSelect,
                isSelected: isSelected,
                onSelected: onSelected,
                onMonthChanged: onMonthChanged,
                accessoryView: accessoryView,
                shouldIgnoreNonCurrentMonthDays: shouldIgnoreNonCurrentMonthDays
            )
        }
    }
}

public extension CXCalendarContext {
    /// Returns a default CXCalendarContext instance with standard configuration.
    static var paged: CXCalendarContext {
        CXCalendarContext.Builder()
            .monthHeader(nil)
            .build()
    }

    static var scrollable: CXCalendarContext {
        CXCalendarContext.Builder()
            .axis(.vertical)
            .calendarHeader { month in
                WeekHeaderView(month: month)
            }
            .monthHeader { month in
                MonthHeaderView(month: month)
            }
            .shouldIgnoreNonCurrentMonthDays(true)
            .style(.scrollable)
            .build()
    }

    var builder: Builder {
        Builder(with: self)
    }
}
