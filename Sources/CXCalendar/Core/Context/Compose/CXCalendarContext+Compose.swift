//
//  CXCalendarCoordinator+Compose.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import SwiftUI

extension CXCalendarContext.Builder {
    public func calendarHeader(_ calendarHeader: ComposeCalendarHeader?) -> CXCalendarContext
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

    public func calendarItem(_ calendarItem: @escaping ComposeCalendarItem) -> CXCalendarContext
        .Builder {
        self.calendarItem = calendarItem
        return self
    }

    public func makeCompose() -> any CXCalendarComposeProtocol {
        CalendarCompose(
            calendarHeader: calendarHeader,
            calendarItem: calendarItem
        )
    }
}
