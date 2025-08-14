//
//  CXCalendarTemplate+Compose.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import SwiftUI

extension CXCalendarTemplate.Builder {
    public func calendarHeader(_ calendarHeader: ComposeCalendarHeader?) -> CXCalendarTemplate
        .Builder {
        self.calendarHeader = calendarHeader
        return self
    }

//    public func body(_ body: @escaping ComposeBody) -> CXCalendarCoordinator.Builder {
//        self.body = body
//        return self
//    }
//
//    public func bodyHeader(_ bodyHeader: ComposeBodyHeader?) -> CXCalendarCoordinator.Builder {
//        self.bodyHeader = bodyHeader
//        return self
//    }
//
//    public func bodyContent(_ bodyContent: @escaping BodyContentMaker) -> CXCalendarCoordinator
//        .Builder {
//        self.bodyContent = bodyContent
//        return self
//    }
//
//    public func weekHeader(_ weekHeader: @escaping WeekHeaderMaker) -> CXCalendarCoordinator.Builder {
//        self.weekHeader = weekHeader
//        return self
//    }
//

    public func calendarItem(_ calendarItem: @escaping ComposeCalendarItem) -> CXCalendarTemplate
        .Builder {
        self.calendarItem = calendarItem
        return self
    }

    public func makeCompose() -> any CXCalendarComposeProtocol {
        if mode == .year {
            calendarItem = { dateInterval, date in
                CalendarMonthMiniItem(dateInterval: dateInterval, date: date)
            }
        }

        return CalendarCompose(
            calendarHeader: calendarHeader,
            calendarItem: calendarItem
        )
    }
}
