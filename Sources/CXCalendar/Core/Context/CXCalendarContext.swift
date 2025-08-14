//
//  CXCalendarContext.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import CXUICore
import SwiftUI

// MARK: - CXCalendarContext

@MainActor
public struct CXCalendarContext {
    /// The core configuration for the calendar.
    public let core: CXCalendarCoreProtocol

    /// The layout configuration for the calendar.
    public let layout: CXCalendarLayoutProtocol

    /// The compose configuration for the calendar.
    public let compose: CXCalendarComposeProtocol

    /// The interaction configuration for the calendar.
    public let interaction: CXCalendarInteractionProtocol
}

// MARK: CXCalendarContext.Builder

extension CXCalendarContext {
    public class Builder:
        CXCalendarLayoutProtocol,
        CXCalendarComposeProtocol,
        CXCalendarInteractionProtocol,
        CXCalendarCoreProtocol {
        // MARK: Lifecycle

        // MARK: - Initializers

        init() { }

        init(from context: CXCalendarContext) {
            // CXCalendarLayoutProtocol
            axis = context.layout.axis
            hPadding = context.layout.hPadding
            vPadding = context.layout.vPadding
            columns = context.layout.columns

            // CXCalendarComposeProtocol
            calendarHeader = context.compose.calendarHeader
            calendarItem = context.compose.calendarItem

            // CXCalendarInteractionProtocol
            canSelect = context.interaction.canSelect
            isSelected = context.interaction.isSelected
            onSelected = context.interaction.onSelected
            onMonthChanged = context.interaction.onMonthChanged

            // CXCalendarCoreProtocol
            calendarType = context.core.calendarType
            mode = context.core.mode
            scrollStrategy = context.core.scrollStrategy
            calendar = context.core.calendar
            startDate = context.core.startDate
            selectedDate = context.core.selectedDate
        }

        // MARK: Public

        // MARK: - CXCalendarCoreProtocol

        public var calendarType = CXCalendarType.month(.page)

        public var mode = CXCalendarMode.month

        public var scrollStrategy = CXCalendarScrollStrategy.page

        public var calendar = Calendar.current

        public var startDate = Date.now

        public var selectedDate = Date.now

        // MARK: - CXCalendarLayoutProtocol

        public var axis = Axis.horizontal

        public var hPadding: CGFloat = CXSpacing.oneX

        public var vPadding: CGFloat = CXSpacing.oneX

        public var columns: [GridItem] = []

        public var itemLayoutStrategy = CXCalendarItemLayoutStrategry.square

        // MARK: - CXCalendarComposeProtocol

        public var calendarHeader: ComposeCalendarHeader? = {
            CXStandardCalendarHeader(date: $0)
        }

        public var calendarItem: ComposeCalendarItem = { dateInterval, date in
            CXCalendarItem(dateInterval: dateInterval, date: date)
        }

        // MARK: - CXCalendarInteractionProtocol

        public var canSelect: CanSelectAction = { _, _, _ in true }

        public var isSelected: IsSelectedAction = { day, selectedDate, calendar in
            selectedDate.map { calendar.isDate(day, inSameDayAs: $0) } ?? false
        }

        public var onSelected: OnSelectedAction?

        public var onMonthChanged: OnMonthChangedAction?
    }
}

// MARK: - Builder Methods

extension CXCalendarContext.Builder {
    // MARK: - CXCalendarInteractionProtocol

    public func canSelect(_ canSelect: @escaping CanSelectAction) -> CXCalendarContext.Builder {
        self.canSelect = canSelect
        return self
    }

    public func isSelected(_ isSelected: @escaping IsSelectedAction) -> CXCalendarContext
        .Builder {
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

    public func build() -> CXCalendarContext {
        let core = makeCore()

        let layout = makeLayout()

        let compose = makeCompose()

        let interaction = CalendarInteraction(
            canSelect: canSelect,
            isSelected: isSelected,
            onSelected: onSelected,
            onMonthChanged: onMonthChanged
        )

        return CXCalendarContext(
            core: core,
            layout: layout,
            compose: compose,
            interaction: interaction
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
            .calendarHeader(nil)
//            .bodyHeader {
//                YearHeaderView(year: $0)
//            }
            .build()
    }

    public static func month(_ scrollBehavior: CXCalendarScrollBehavior) -> CXCalendarContext {
        var builder = CXCalendarContext.Builder()
            .calendarType(.month(scrollBehavior))

        if scrollBehavior == .scroll {
//            builder = builder
//                .bodyHeader { month in
//                    MonthHeaderView(month: month)
//                }
        }
        return builder.build()
    }

    public static func week() -> CXCalendarContext {
        CXCalendarContext.Builder()
            .calendarType(.week)
            .build()
    }
}
