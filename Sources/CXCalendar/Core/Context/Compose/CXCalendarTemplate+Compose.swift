//
//  CXCalendarTemplate+Compose.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import SwiftUI

extension CXCalendarTemplate.Builder {
    // MARK: Public

    public func calendarHeader(_ calendarHeader: ComposeCalendarHeader?) -> CXCalendarTemplate
        .Builder {
        self.calendarHeader = calendarHeader
        return self
    }

    public func calendarPageHeader(_ calendarPageHeader: @escaping ComposeCalendarHeader)
        -> CXCalendarTemplate
        .Builder {
        self.calendarPageHeader = calendarPageHeader
        return self
    }

    public func calendarItem(_ calendarItem: @escaping ComposeCalendarItem) -> CXCalendarTemplate
        .Builder {
        self.calendarItem = calendarItem
        return self
    }

    public func accessoryView(_ accessoryView: ComposeCalendarAccessoryView?) -> CXCalendarTemplate
        .Builder {
        self.accessoryView = accessoryView
        return self
    }

    // MARK: Internal

    func makeCompose() -> any CXCalendarComposeProtocol {
        if mode == .year {
            calendarItem = { dateInterval, date in
                CalendarMonthMiniItem(dateInterval: dateInterval, date: date)
            }
        }

        return CalendarCompose(
            calendarHeader: calendarHeader,
            calendarPageHeader: calendarPageHeader,
            calendarItem: calendarItem,
            accessoryView: accessoryView
        )
    }
}
