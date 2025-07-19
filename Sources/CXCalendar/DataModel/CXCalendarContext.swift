//
//  CXCalendarContext.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import CXUICore
import SwiftUI

// MARK: - CXCalendarContext

public struct CXCalendarContext {
    /// Calendar type of the calendar (month or week)
    public let calendarType: CXCalendarType

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

// MARK: CXCalendarContext.Builder

extension CXCalendarContext {
    public class Builder: CXCalendarLayoutProtocol, CXCalendarComposeProtocol,
        CXCalendarInteractionProtocol {
        // MARK: Lifecycle

        // MARK: - Initializers

        init() { }

        init(from context: CXCalendarContext) {
            // Basic
            calendarType = context.calendarType
            calendar = context.calendar
            startDate = context.startDate
            selectedDate = context.selectedDate

            // CXCalendarLayoutProtocol
            axis = context.layout.axis
            columnPadding = context.layout.columnPadding
            rowPadding = context.layout.rowPadding
            rowHeight = context.layout.rowHeight
            calendarHPadding = context.layout.calendarHPadding

            // CXCalendarComposeProtocol
            calendarHeader = context.compose.calendarHeader
            bodyHeader = context.compose.bodyHeader
            weekHeader = context.compose.weekHeader
            dayView = context.compose.dayView
            accessoryView = context.compose.accessoryView

            // CXCalendarInteractionProtocol
            canSelect = context.interaction.canSelect
            isSelected = context.interaction.isSelected
            shouldHideWhenOutOfBounds = context.interaction.shouldHideWhenOutOfBounds
            onSelected = context.interaction.onSelected
            onMonthChanged = context.interaction.onMonthChanged
        }

        // MARK: Public

        // MARK: - Basic

        /// Content type of the calendar (month or week)
        public private(set) var calendarType = CXCalendarType.month(.page)

        /// Calendar used for all date and calculation logic.
        public private(set) var calendar = Calendar.current

        /// The calendar's starting display date.
        public private(set) var startDate = Date.now

        /// The date initially selected by the calendar, if any.
        public private(set) var selectedDate: Date?

        // MARK: - CXCalendarLayoutProtocol

        public private(set) var axis = Axis.horizontal

        public private(set) var columnPadding: CGFloat = CXSpacing.oneX

        public private(set) var rowPadding: CGFloat = CXSpacing.oneX

        public private(set) var rowHeight: CGFloat = CXSpacing.sixX

        public private(set) var calendarHPadding: CGFloat = CXSpacing.oneX

        // MARK: - CXCalendarComposeProtocol

        public private(set) var calendarHeader: CalendarHeaderMaker = { month in
            CalendarHeaderView(date: month)
        }

        public private(set) var bodyHeader: BodyHeaderMaker?

        public private(set) var weekHeader: WeekHeaderMaker = { month in
            WeekHeaderView(month: month)
        }

        public private(set) var dayView: DayViewMaker = { dateInterval, day in
            DayView(dateInterval: dateInterval, day: day)
        }

        public private(set) var accessoryView: AccessoryViewMaker?

        // MARK: - CXCalendarInteractionProtocol

        public private(set) var canSelect: CanSelectAction = { _, _, _ in true }

        public private(set) var isSelected: IsSelectedAction = { day, selectedDate, calendar in
            selectedDate.map { calendar.isDate(day, inSameDayAs: $0) } ?? false
        }

        public private(set) var shouldHideWhenOutOfBounds = false

        public private(set) var onSelected: OnSelectedAction?

        public private(set) var onMonthChanged: OnMonthChangedAction?
    }
}

// MARK: - Convenience accessors

extension CXCalendarContext {
    /// Returns a pre-configured CXCalendarContext instance for `CXCalendarStyle.paged`
    /// this context is targetting to serve `CXPagedCalendar` ONLY
    public static var paged: CXCalendarContext {
        CXCalendarContext.Builder()
            .bodyHeader(nil)
            .build()
    }

    /// Returns a pre-configured CXCalendarContext instance for `CXCalendarStyle.scrollable`
    /// this context is targetting to serve `CXScrollableCalendar` ONLY
    public static var scrollable: CXCalendarContext {
        CXCalendarContext.Builder()
            .axis(.vertical)
            .shouldHideWhenOutOfBounds(true)
            .calendarHeader { month in
                WeekHeaderView(month: month)
            }
            .bodyHeader { month in
                MonthHeaderView(month: month)
            }
            .build()
    }

    /// Returns a builder instance initialized with the current context.
    public var builder: CXCalendarContext.Builder {
        CXCalendarContext.Builder(from: self)
    }
}

// MARK: - Builder Methods

extension CXCalendarContext.Builder {
    // MARK: - Basic

    public func calendarType(_ calendarType: CXCalendarType) -> CXCalendarContext.Builder {
        self.calendarType = calendarType
        return self
    }

    public func calendar(_ calendar: Calendar) -> CXCalendarContext.Builder {
        self.calendar = calendar
        return self
    }

    public func startDate(_ startDate: Date) -> CXCalendarContext.Builder {
        self.startDate = startDate
        return self
    }

    public func selectedDate(_ selectedDate: Date?) -> CXCalendarContext.Builder {
        self.selectedDate = selectedDate
        return self
    }

    // MARK: - CXCalendarLayoutProtocol

    public func axis(_ axis: Axis) -> CXCalendarContext.Builder {
        self.axis = axis
        return self
    }

    public func columnPadding(_ columnPadding: CGFloat) -> CXCalendarContext.Builder {
        self.columnPadding = columnPadding
        return self
    }

    public func rowPadding(_ rowPadding: CGFloat) -> CXCalendarContext.Builder {
        self.rowPadding = rowPadding
        return self
    }

    public func rowHeight(_ rowHeight: CGFloat) -> CXCalendarContext.Builder {
        self.rowHeight = rowHeight
        return self
    }

    public func calendarHPadding(_ calendarHPadding: CGFloat) -> CXCalendarContext.Builder {
        self.calendarHPadding = calendarHPadding
        return self
    }

    // MARK: - CXCalendarComposeProtocol

    public func calendarHeader(_ calendarHeader: @escaping (Date)
        -> any CXCalendarHeaderViewRepresentable
    ) -> CXCalendarContext.Builder {
        self.calendarHeader = calendarHeader
        return self
    }

    public func bodyHeader(_ bodyHeader: BodyHeaderMaker?)
        -> CXCalendarContext.Builder {
        self.bodyHeader = bodyHeader
        return self
    }

    public func weekHeader(_ weekHeader: @escaping WeekHeaderMaker)
        -> CXCalendarContext.Builder {
        self.weekHeader = weekHeader
        return self
    }

    public func dayView(_ dayView: @escaping DayViewMaker)
        -> CXCalendarContext.Builder {
        self.dayView = dayView
        return self
    }

    public func accessoryView(_ accessoryView: AccessoryViewMaker?) -> CXCalendarContext.Builder {
        self.accessoryView = accessoryView
        return self
    }

    // MARK: - CXCalendarInteractionProtocol

    public func canSelect(_ canSelect: @escaping CanSelectAction)
        -> CXCalendarContext.Builder {
        self.canSelect = canSelect
        return self
    }

    public func isSelected(_ isSelected: @escaping IsSelectedAction)
        -> CXCalendarContext.Builder {
        self.isSelected = isSelected
        return self
    }

    public func shouldHideWhenOutOfBounds(_ shouldHideWhenOutOfBounds: Bool)
        -> CXCalendarContext.Builder {
        self.shouldHideWhenOutOfBounds = shouldHideWhenOutOfBounds
        return self
    }

    public func onSelected(_ onSelected: OnSelectedAction?) -> CXCalendarContext.Builder {
        self.onSelected = onSelected
        return self
    }

    public func onMonthChanged(_ onMonthChanged: OnMonthChangedAction?)
        -> CXCalendarContext.Builder {
        self.onMonthChanged = onMonthChanged
        return self
    }

    public func build() -> CXCalendarContext {
        let layout = CalendarLayout(
            axis: axis,
            columnPadding: columnPadding,
            rowPadding: rowPadding,
            rowHeight: rowHeight,
            calendarHPadding: calendarHPadding
        )
        let compose = CalendarCompose(
            calendarHeader: calendarHeader,
            bodyHeader: bodyHeader,
            weekHeader: weekHeader,
            dayView: dayView,
            accessoryView: accessoryView
        )
        let interaction = CalendarInteraction(
            canSelect: canSelect,
            isSelected: isSelected,
            shouldHideWhenOutOfBounds: shouldHideWhenOutOfBounds,
            onSelected: onSelected,
            onMonthChanged: onMonthChanged
        )

        return CXCalendarContext(
            calendarType: calendarType,
            calendar: calendar,
            startDate: startDate,
            selectedDate: selectedDate,
            layout: layout,
            compose: compose,
            interaction: interaction
        )
    }
}
