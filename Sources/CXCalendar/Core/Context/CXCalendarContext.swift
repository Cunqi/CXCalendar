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
}

// MARK: CXCalendarContext.Builder

extension CXCalendarContext {
    public class Builder:
        CXCalendarLayoutProtocol,
        CXCalendarComposeProtocol,
        CXCalendarCoreProtocol {
        // MARK: Lifecycle

        // MARK: - Initializers

        init() { }

        init(from context: CXCalendarContext) {
            // CXCalendarCoreProtocol
            mode = context.core.mode
            scrollStrategy = context.core.scrollStrategy
            calendar = context.core.calendar
            startDate = context.core.startDate
            selectedDate = context.core.selectedDate

            // CXCalendarLayoutProtocol
            axis = context.layout.axis
            hPadding = context.layout.hPadding
            vPadding = context.layout.vPadding
            columns = context.layout.columns

            // CXCalendarComposeProtocol
            calendarHeader = context.compose.calendarHeader
            calendarItem = context.compose.calendarItem
        }

        // MARK: Public

        // MARK: - CXCalendarCoreProtocol

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

        public func build() -> CXCalendarContext {
            CXCalendarContext(
                core: makeCore(),
                layout: makeLayout(),
                compose: makeCompose()
            )
        }
    }
}

// MARK: - Convenience accessors

extension CXCalendarContext {
    public var builder: CXCalendarContext.Builder {
        CXCalendarContext.Builder(from: self)
    }

    /// Not recommended to use, has performance issues since it will render ~400 items at once.
    public static func year(_ scrollStrategy: CXCalendarScrollStrategy = .page)
        -> CXCalendarContext {
        CXCalendarContext.Builder()
            .mode(.year)
            .scrollStrategy(scrollStrategy)
            .itemLayoutStrategy(.flexHeight)
            .build()
    }

    public static func month(_ scrollStrategy: CXCalendarScrollStrategy = .page)
        -> CXCalendarContext {
        var builder = CXCalendarContext.Builder()
            .mode(.month)
            .scrollStrategy(scrollStrategy)

        if scrollStrategy == .scroll {
//            builder = builder
//                .bodyHeader { month in
//                    MonthHeaderView(month: month)
//                }
        }
        return builder.build()
    }

    public static func week() -> CXCalendarContext {
        CXCalendarContext.Builder()
            .mode(.week)
            .scrollStrategy(.page)
            .build()
    }
}
