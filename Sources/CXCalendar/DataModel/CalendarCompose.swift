//
//  CalendarCompose.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

// MARK: - Typealias

public typealias CalendarHeaderMaker = (Date) -> any CXCalendarViewRepresentable

public typealias BodyHeaderMaker = (Date) -> any CXCalendarViewRepresentable

public typealias BodyContentMaker = (Date) -> any CXCalendarBodyContentViewRepresentable

public typealias WeekHeaderMaker = (Date) -> any CXCalendarViewRepresentable

public typealias DayViewMaker = (DateInterval, Date, Namespace.ID)
    -> any CXCalendarDayViewRepresentable

public typealias AccessoryViewMaker = (Date) -> any View

// MARK: - CXCalendarComposeProtocol

public protocol CXCalendarComposeProtocol {
    /// Closure returning a SwiftUI View for the calendar header, given the current month date.
    var calendarHeader: CalendarHeaderMaker { get }

    /// Closure returning a SwiftUI View for the body header, given the current month date.
    /// This is used to display the month title along with the month view.
    var bodyHeader: BodyHeaderMaker? { get }

    /// Closure returning a SwiftUI View for the body content, given the current month date.
    /// This is used to display the main content of the calendar view. (e.g., the month view)
    var bodyContent: BodyContentMaker { get }

    /// Closure returning a SwiftUI View for the week header, given the current month date.
    /// This is used to display the week title of calendar view.
    var weekHeader: WeekHeaderMaker { get }

    /// Closure returning a SwiftUI View for individual days, given the date interval and day dates.
    var dayView: DayViewMaker { get }

    /// Optional closure returning a SwiftUI View to overlay when a day is selected.
    var accessoryView: AccessoryViewMaker? { get }
}

// MARK: - CalendarCompose

struct CalendarCompose: CXCalendarComposeProtocol {
    let calendarHeader: CalendarHeaderMaker

    let bodyHeader: BodyHeaderMaker?

    let bodyContent: BodyContentMaker

    let weekHeader: WeekHeaderMaker

    let dayView: DayViewMaker

    let accessoryView: AccessoryViewMaker?
}
