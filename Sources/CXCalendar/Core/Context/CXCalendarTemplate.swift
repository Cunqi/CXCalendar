//
//  CXCalendarTemplate.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import CXUICore
import SwiftUI

// MARK: - CXCalendarTemplate

@MainActor
public struct CXCalendarTemplate {
    /// The core configuration for the calendar.
    public let core: CXCalendarCoreProtocol

    /// The layout configuration for the calendar.
    public let layout: CXCalendarLayoutProtocol

    /// The compose configuration for the calendar.
    public let compose: CXCalendarComposeProtocol

    /// The interaction configuration for the calendar.
    public let interaction: CXCalendarInteractionProtocol
}

// MARK: CXCalendarTemplate.Builder

extension CXCalendarTemplate {
    public class Builder:
        CXCalendarLayoutProtocol,
        CXCalendarComposeProtocol,
        CXCalendarCoreProtocol,
        CXCalendarInteractionProtocol {
        // MARK: Lifecycle

        // MARK: - Initializers

        init() { }

        init(from template: CXCalendarTemplate) {
            // CXCalendarCoreProtocol
            mode = template.core.mode
            scrollStrategy = template.core.scrollStrategy
            calendar = template.core.calendar
            startDate = template.core.startDate
            selectedDate = template.core.selectedDate

            // CXCalendarLayoutProtocol
            axis = template.layout.axis
            hPadding = template.layout.hPadding
            vPadding = template.layout.vPadding
            columns = template.layout.columns

            // CXCalendarComposeProtocol
            calendarHeader = template.compose.calendarHeader
            calendarItem = template.compose.calendarItem

            // CXCalendarInteractionProtocol
            onCalendarItemSelect = template.interaction.onCalendarItemSelect
            onAnchorDateChange = template.interaction.onAnchorDateChange
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

        // MARK: - CXCalendarInteractionProtocol

        public var onCalendarItemSelect: OnCalendarItemSelect?

        public var onAnchorDateChange: OnAnchorDateChange?

        public func build() -> CXCalendarTemplate {
            CXCalendarTemplate(
                core: makeCore(),
                layout: makeLayout(),
                compose: makeCompose(),
                interaction: makeInteraction()
            )
        }
    }
}

// MARK: - Convenience accessors

extension CXCalendarTemplate {
    public var builder: CXCalendarTemplate.Builder {
        CXCalendarTemplate.Builder(from: self)
    }

    /// Not recommended to use, has performance issues since it will render ~400 items at once.
    public static func year(_ scrollStrategy: CXCalendarScrollStrategy = .page)
        -> CXCalendarTemplate {
        CXCalendarTemplate.Builder()
            .mode(.year)
            .scrollStrategy(scrollStrategy)
            .itemLayoutStrategy(.flexHeight)
            .build()
    }

    public static func month(_ scrollStrategy: CXCalendarScrollStrategy = .page)
        -> CXCalendarTemplate {
        var builder = CXCalendarTemplate.Builder()
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

    public static func week() -> CXCalendarTemplate {
        CXCalendarTemplate.Builder()
            .mode(.week)
            .scrollStrategy(.page)
            .build()
    }
}
