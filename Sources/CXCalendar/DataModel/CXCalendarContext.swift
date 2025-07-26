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

    /// The date initially selected by the calendar, default is `startDate`.
    public let selectedDate: Date

    /// The layout configuration for the calendar.
    public let layout: CXCalendarLayoutProtocol

    /// The compose configuration for the calendar.
    public let compose: CXCalendarComposeProtocol

    /// The interaction configuration for the calendar.
    public let interaction: CXCalendarInteractionProtocol

    /// The theme configuration for the calendar.
    public let theme: CXCalendarThemeProtocol
}

// MARK: CXCalendarContext.Builder

extension CXCalendarContext {
    public class Builder: CXCalendarLayoutProtocol, CXCalendarComposeProtocol,
        CXCalendarInteractionProtocol, CXCalendarThemeProtocol {
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
            bodyHeaderHeight = context.layout.bodyHeaderHeight
            rowHeight = context.layout.rowHeight
            calendarHPadding = context.layout.calendarHPadding

            // CXCalendarComposeProtocol
            calendarHeader = context.compose.calendarHeader
            body = context.compose.body
            bodyHeader = context.compose.bodyHeader
            bodyContent = context.compose.bodyContent
            weekHeader = context.compose.weekHeader
            dayView = context.compose.dayView
            accessoryView = context.compose.accessoryView

            // CXCalendarInteractionProtocol
            canSelect = context.interaction.canSelect
            isSelected = context.interaction.isSelected
            onSelected = context.interaction.onSelected
            onMonthChanged = context.interaction.onMonthChanged

            // CXCalendarThemeProtocol
            accentColor = context.theme.accentColor
            selectedColor = context.theme.selectedColor
        }

        // MARK: Public

        // MARK: - Basic

        public private(set) var calendarType = CXCalendarType.month(.page)

        public private(set) var calendar = Calendar.current

        public private(set) var startDate = Date.now

        public private(set) var selectedDate = Date.now

        // MARK: - CXCalendarLayoutProtocol

        public private(set) var axis = Axis.horizontal

        public private(set) var columnPadding: CGFloat = CXSpacing.oneX

        public private(set) var rowPadding: CGFloat = CXSpacing.oneX

        public private(set) var bodyHeaderHeight: CGFloat = CXSpacing.fiveX

        public private(set) var rowHeight: CGFloat = CXSpacing.sixX

        public private(set) var calendarHPadding: CGFloat = CXSpacing.oneX

        // MARK: - CXCalendarComposeProtocol

        public private(set) var calendarHeader: CalendarHeaderMaker = { month in
            CalendarHeaderView(date: month)
        }

        public private(set) var body: BodyMaker = { month in
            CalendarMonthlyBodyView(date: month)
        }

        public private(set) var bodyHeader: BodyHeaderMaker?

        public private(set) var bodyContent: BodyContentMaker = { date in
            CalendarMonthlyBodyContentView(date: date)
        }

        public private(set) var weekHeader: WeekHeaderMaker = { month in
            WeekHeaderView(month: month)
        }

        public private(set) var dayView: DayViewMaker = { dateInterval, day, namespace in
            CalendarDayView(dateInterval: dateInterval, date: day, namespace: namespace)
        }

        public private(set) var accessoryView: AccessoryViewMaker?

        // MARK: - CXCalendarInteractionProtocol

        public private(set) var canSelect: CanSelectAction = { _, _, _ in true }

        public private(set) var isSelected: IsSelectedAction = { day, selectedDate, calendar in
            selectedDate.map { calendar.isDate(day, inSameDayAs: $0) } ?? false
        }

        public private(set) var onSelected: OnSelectedAction?

        public private(set) var onMonthChanged: OnMonthChangedAction?

        // MARK: - CXCalendarThemeProtocol

        public private(set) var accentColor = Color.red

        public private(set) var selectedColor = Color.blue
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

    public func selectedDate(_ selectedDate: Date) -> CXCalendarContext.Builder {
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

    public func bodyHeaderHeight(_ bodyHeaderHeight: CGFloat) -> CXCalendarContext.Builder {
        self.bodyHeaderHeight = bodyHeaderHeight
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
        -> any CXCalendarViewRepresentable
    ) -> CXCalendarContext.Builder {
        self.calendarHeader = calendarHeader
        return self
    }

    public func body(_ body: @escaping BodyMaker) -> CXCalendarContext.Builder {
        self.body = body
        return self
    }

    public func bodyHeader(_ bodyHeader: BodyHeaderMaker?) -> CXCalendarContext.Builder {
        self.bodyHeader = bodyHeader
        return self
    }

    public func bodyContent(_ bodyContent: @escaping BodyContentMaker) -> CXCalendarContext
        .Builder {
        self.bodyContent = bodyContent
        return self
    }

    public func weekHeader(_ weekHeader: @escaping WeekHeaderMaker) -> CXCalendarContext.Builder {
        self.weekHeader = weekHeader
        return self
    }

    public func dayView(_ dayView: @escaping DayViewMaker) -> CXCalendarContext.Builder {
        self.dayView = dayView
        return self
    }

    public func accessoryView(_ accessoryView: AccessoryViewMaker?) -> CXCalendarContext.Builder {
        self.accessoryView = accessoryView
        return self
    }

    // MARK: - CXCalendarInteractionProtocol

    public func canSelect(_ canSelect: @escaping CanSelectAction) -> CXCalendarContext.Builder {
        self.canSelect = canSelect
        return self
    }

    public func isSelected(_ isSelected: @escaping IsSelectedAction) -> CXCalendarContext.Builder {
        self.isSelected = isSelected
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

    // MARK: - CXCalendarThemeProtocol

    public func accentColor(_ accentColor: Color) -> CXCalendarContext.Builder {
        self.accentColor = accentColor
        return self
    }

    public func selectedColor(_ selectedColor: Color) -> CXCalendarContext.Builder {
        self.selectedColor = selectedColor
        return self
    }

    public func build() -> CXCalendarContext {
        switch calendarType {
        case .month(.scroll):
            axis = .vertical
        case .year:
            axis = .vertical
            calendarHeader = {
                YearHeaderView(year: $0)
            }
            body = {
                CalendarYearlyBodyView(date: $0)
            }
            bodyHeader = {
                CalendarYearlyBodyHeaderView(month: $0)
            }
            bodyHeaderHeight = CXSpacing.twoX
            rowHeight = CXSpacing.twoX
            rowPadding = .zero
        default:
            break
        }

        let layout = CalendarLayout(
            axis: axis,
            columnPadding: columnPadding,
            rowPadding: rowPadding,
            bodyHeaderHeight: bodyHeaderHeight,
            rowHeight: rowHeight,
            calendarHPadding: calendarHPadding
        )
        let compose = CalendarCompose(
            calendarHeader: calendarHeader,
            body: body,
            bodyHeader: bodyHeader,
            bodyContent: bodyContent,
            weekHeader: weekHeader,
            dayView: dayView,
            accessoryView: accessoryView
        )
        let interaction = CalendarInteraction(
            canSelect: canSelect,
            isSelected: isSelected,
            onSelected: onSelected,
            onMonthChanged: onMonthChanged
        )

        let theme = CalendarTheme(
            accentColor: accentColor,
            selectedColor: selectedColor
        )

        return CXCalendarContext(
            calendarType: calendarType,
            calendar: calendar,
            startDate: startDate,
            selectedDate: selectedDate,
            layout: layout,
            compose: compose,
            interaction: interaction,
            theme: theme
        )
    }
}

// MARK: - Convenience accessors

extension CXCalendarContext {
    public var builder: CXCalendarContext.Builder {
        CXCalendarContext.Builder(from: self)
    }

    public static func year(_ scrollBehavior: CXCalendarScrollBehavior) -> CXCalendarContext {
        CXCalendarContext.Builder()
            .calendarType(.year(scrollBehavior))
            .build()
    }

    public static func month(_ scrollBehavior: CXCalendarScrollBehavior) -> CXCalendarContext {
        var builder = CXCalendarContext.Builder()
            .calendarType(.month(scrollBehavior))

        if scrollBehavior == .scroll {
            builder = builder
                .bodyHeader { month in
                    MonthHeaderView(month: month)
                }
        }
        return builder.build()
    }

    public static func week() -> CXCalendarContext {
        CXCalendarContext.Builder()
            .calendarType(.week)
            .build()
    }
}
