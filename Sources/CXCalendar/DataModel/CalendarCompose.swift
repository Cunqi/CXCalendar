//
//  CalendarCompose.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

public protocol CXCalendarComposeProtocol {
    /// Closure returning a SwiftUI View for the calendar header, given the current month date.
    var calendarHeader: (Date) -> any CXCalendarHeaderViewRepresentable { get }

    /// Closure returning a SwiftUI View for the month header, given the current month date.
    /// This is used to display the month title along with the month view.
    var monthHeader: ((Date) -> any CXCalendarHeaderViewRepresentable)? { get }

    /// Closure returning a SwiftUI View for the week header, given the current month date.
    /// This is used to display the week title of calendar view.
    var weekHeader: (Date) -> any CXCalendarHeaderViewRepresentable { get }

    /// Closure returning a SwiftUI View for individual days, given the month and day dates.
    var dayView: (Date, Date) -> any CXDayViewRepresentable { get }

    /// Optional closure returning a SwiftUI View to overlay when a day is selected.
    var accessoryView: ((Date) -> any View)? { get }
}

struct CalendarCompose: CXCalendarComposeProtocol {
    let calendarHeader: (Date) -> any CXCalendarHeaderViewRepresentable

    let monthHeader: ((Date) -> any CXCalendarHeaderViewRepresentable)?

    let weekHeader: (Date) -> any CXCalendarHeaderViewRepresentable

    let dayView: (Date, Date) -> any CXDayViewRepresentable

    let accessoryView: ((Date) -> any View)?
}
