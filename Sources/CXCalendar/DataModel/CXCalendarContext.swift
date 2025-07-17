//
//  CXCalendarContext.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import CXUICore
import SwiftUI

public struct CXCalendarContext {
    /// Style of the calendar (paged or scrollable)
    public let style: CXCalendarStyle

    /// Calendar used for all date and calculation logic.
    public let calendar: Calendar

    /// The calendar's starting display date.
    public let startDate: Date

    /// The date initially selected by the calendar, if any.
    public let selectedDate: Date?

    public let layout: CXCalendarLayoutProtocol

    public let compose: CXCalendarComposeProtocol

    public let interaction: CXCalendarInteractionProtocol
}

public extension CXCalendarContext {
    class Builder: CXCalendarLayoutProtocol, CXCalendarComposeProtocol, CXCalendarInteractionProtocol {
        // MARK: - Basic

        /// Style of the calendar (paged or scrollable)
        public private(set) var style: CXCalendarStyle = .paged

        /// Calendar used for all date and calculation logic.
        public private(set) var calendar: Calendar = .current

        /// The calendar's starting display date.
        public private(set) var startDate: Date = .now

        /// The date initially selected by the calendar, if any.
        public private(set) var selectedDate: Date?

        // MARK: - CXCalendarLayoutProtocol

        public private(set) var axis: Axis = .horizontal

        public private(set) var columnPadding: CGFloat = CXSpacing.oneX

        public private(set) var rowPadding: CGFloat = CXSpacing.oneX

        public private(set) var rowHeight: CGFloat = CXSpacing.sixX

        // MARK: - CXCalendarComposeProtocol

        public private(set) var calendarHeader: (Date) -> any CXCalendarHeaderViewRepresentable = { month in
            CalendarHeaderView(month: month)
        }

        public private(set) var monthHeader: ((Date) -> any CXCalendarHeaderViewRepresentable)?

        public private(set) var weekHeader: (Date) -> any CXCalendarHeaderViewRepresentable = { month in
            WeekHeaderView(month: month)
        }

        public private(set) var dayView: (Date, Date) -> any CXDayViewRepresentable = { month, day in
            DayView(month: month, day: day)
        }

        public private(set) var accessoryView: ((Date) -> any View)?

        // MARK: - CXCalendarInteractionProtocol

        public private(set) var canSelect: (Date, Date, Calendar) -> Bool = { _, _, _ in true }

        public private(set) var isSelected: (Date, Date?, Calendar) -> Bool = { day, selectedDate, calendar in
            selectedDate.map { calendar.isDate(day, inSameDayAs: $0) } ?? false
        }

        public private(set) var shouldHideNonCurrentMonthDays: Bool = false

        public private(set) var onSelected: ((Date?) -> Void)?

        public private(set) var onMonthChanged: ((Date) -> Void)?

        // MARK: - Initializers

        init() {}

        init(from context: CXCalendarContext) {
            // Basic
            style = context.style
            calendar = context.calendar
            startDate = context.startDate
            selectedDate = context.selectedDate

            // CXCalendarLayoutProtocol
            axis = context.layout.axis
            columnPadding = context.layout.columnPadding
            rowPadding = context.layout.rowPadding
            rowHeight = context.layout.rowHeight

            // CXCalendarComposeProtocol
            calendarHeader = context.compose.calendarHeader
            monthHeader = context.compose.monthHeader
            weekHeader = context.compose.weekHeader
            dayView = context.compose.dayView
            accessoryView = context.compose.accessoryView

            // CXCalendarInteractionProtocol
            canSelect = context.interaction.canSelect
            isSelected = context.interaction.isSelected
            shouldHideNonCurrentMonthDays = context.interaction.shouldHideNonCurrentMonthDays
            onSelected = context.interaction.onSelected
            onMonthChanged = context.interaction.onMonthChanged
        }
    }
}

// MARK: - Convenience accessors

public extension CXCalendarContext {
    /// Returns a pre-configured CXCalendarContext instance for `CXCalendarStyle.paged`
    /// this context is targetting to serve `CXPagedCalendar` ONLY
    static var paged: CXCalendarContext {
        CXCalendarContext.Builder()
            .style(.paged)
            .monthHeader(nil)
            .build()
    }

    /// Returns a pre-configured CXCalendarContext instance for `CXCalendarStyle.scrollable`
    /// this context is targetting to serve `CXScrollableCalendar` ONLY
    static var scrollable: CXCalendarContext {
        CXCalendarContext.Builder()
            .style(.scrollable)
            .axis(.vertical)
            .calendarHeader { month in
                WeekHeaderView(month: month)
            }
            .monthHeader { month in
                MonthHeaderView(month: month)
            }
            .build()
    }

    /// Returns a builder instance initialized with the current context.
    var builder: CXCalendarContext.Builder {
        CXCalendarContext.Builder(from: self)
    }
}

// MARK: - Builder Methods

public extension CXCalendarContext.Builder {
    // MARK: - Basic

    func style(_ style: CXCalendarStyle) -> CXCalendarContext.Builder {
        self.style = style
        return self
    }

    func calendar(_ calendar: Calendar) -> CXCalendarContext.Builder {
        self.calendar = calendar
        return self
    }

    func startDate(_ startDate: Date) -> CXCalendarContext.Builder {
        self.startDate = startDate
        return self
    }

    func selectedDate(_ selectedDate: Date?) -> CXCalendarContext.Builder {
        self.selectedDate = selectedDate
        return self
    }

    // MARK: - CXCalendarLayoutProtocol

    func axis(_ axis: Axis) -> CXCalendarContext.Builder {
        self.axis = axis
        return self
    }

    func columnPadding(_ columnPadding: CGFloat) -> CXCalendarContext.Builder {
        self.columnPadding = columnPadding
        return self
    }

    func rowPadding(_ rowPadding: CGFloat) -> CXCalendarContext.Builder {
        self.rowPadding = rowPadding
        return self
    }

    func rowHeight(_ rowHeight: CGFloat) -> CXCalendarContext.Builder {
        self.rowHeight = rowHeight
        return self
    }

    // MARK: - CXCalendarComposeProtocol

    func calendarHeader(_ calendarHeader: @escaping (Date) -> any CXCalendarHeaderViewRepresentable) -> CXCalendarContext.Builder {
        self.calendarHeader = calendarHeader
        return self
    }

    func monthHeader(_ monthHeader: ((Date) -> any CXCalendarHeaderViewRepresentable)?) -> CXCalendarContext.Builder {
        self.monthHeader = monthHeader
        return self
    }

    func weekHeader(_ weekHeader: @escaping (Date) -> any CXCalendarHeaderViewRepresentable) -> CXCalendarContext.Builder {
        self.weekHeader = weekHeader
        return self
    }

    func dayView(_ dayView: @escaping (Date, Date) -> any CXDayViewRepresentable) -> CXCalendarContext.Builder {
        self.dayView = dayView
        return self
    }

    func accessoryView(_ accessoryView: ((Date) -> any View)?) -> CXCalendarContext.Builder {
        self.accessoryView = accessoryView
        return self
    }

    // MARK: - CXCalendarInteractionProtocol

    func canSelect(_ canSelect: @escaping (Date, Date, Calendar) -> Bool) -> CXCalendarContext.Builder {
        self.canSelect = canSelect
        return self
    }

    func isSelected(_ isSelected: @escaping (Date, Date?, Calendar) -> Bool) -> CXCalendarContext.Builder {
        self.isSelected = isSelected
        return self
    }

    func shouldHideNonCurrentMonthDays(_ shouldHideNonCurrentMonthDays: Bool) -> CXCalendarContext.Builder {
        self.shouldHideNonCurrentMonthDays = shouldHideNonCurrentMonthDays
        return self
    }

    func onSelected(_ onSelected: ((Date?) -> Void)?) -> CXCalendarContext.Builder {
        self.onSelected = onSelected
        return self
    }

    func onMonthChanged(_ onMonthChanged: ((Date) -> Void)?) -> CXCalendarContext.Builder {
        self.onMonthChanged = onMonthChanged
        return self
    }

    func build() -> CXCalendarContext {
        let layout = CalendarLayout(
            axis: axis,
            columnPadding: columnPadding,
            rowPadding: rowPadding,
            rowHeight: rowHeight
        )
        let compose = CalendarCompose(
            calendarHeader: calendarHeader,
            monthHeader: monthHeader,
            weekHeader: weekHeader,
            dayView: dayView,
            accessoryView: accessoryView
        )
        let interaction = CalendarInteraction(
            canSelect: canSelect,
            isSelected: isSelected,
            shouldHideNonCurrentMonthDays: shouldHideNonCurrentMonthDays,
            onSelected: onSelected,
            onMonthChanged: onMonthChanged
        )

        return CXCalendarContext(
            style: style,
            calendar: calendar,
            startDate: startDate,
            selectedDate: selectedDate,
            layout: layout,
            compose: compose,
            interaction: interaction
        )
    }
}
