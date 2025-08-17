//
//  CalendarCompose.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

// MARK: - Typealias

public typealias ComposeCalendarHeader = (Date) -> any CXCalendarViewRepresentable

public typealias ComposeCalendarItem = (DateInterval, CXIndexedDate)
    -> any CXCalendarItemViewRepresentable

public typealias ComposeCalendarAccessoryView = (Date)
    -> any View

// MARK: - CXCalendarComposeProtocol

@MainActor
public protocol CXCalendarComposeProtocol {
    /// Closure returning a SwiftUI View for the calendar header, given the current month date.
    var calendarHeader: ComposeCalendarHeader? { get }

    /// Closure returning a SwiftUI View for the calendar page header, given the current month date.
    var calendarPageHeader: ComposeCalendarHeader { get }

    /// Closure returning a SwiftUI View for individual items, given the date interval and day dates.
    var calendarItem: ComposeCalendarItem { get }

    /// Closure returning a SwiftUI View for accessory items, given the date.
    var accessoryView: ComposeCalendarAccessoryView? { get }
}

// MARK: - CalendarCompose

struct CalendarCompose: CXCalendarComposeProtocol {
    let calendarHeader: ComposeCalendarHeader?

    let calendarPageHeader: ComposeCalendarHeader

    let calendarItem: ComposeCalendarItem

    let accessoryView: ComposeCalendarAccessoryView?
}
