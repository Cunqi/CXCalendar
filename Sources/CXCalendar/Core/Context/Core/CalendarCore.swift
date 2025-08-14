//
//  CalendarCore.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import Foundation

// MARK: - CXCalendarCoreProtocol

@MainActor
public protocol CXCalendarCoreProtocol {
    /// The calendar mode of the calendar (year, month or week)
    var mode: CXCalendarMode { get }

    /// The scroll strategy of the calendar (scroll or page)
    var scrollStrategy: CXCalendarScrollStrategy { get }

    /// Calendar used for all date and calculation logic.
    var calendar: Calendar { get }

    /// The start date of the calendar, representing the anchor date from which the calendar is displayed.
    var startDate: Date { get }

    /// The date initially selected by the calendar, default is `startDate`.
    var selectedDate: Date { get }
}

// MARK: - CalendarCore

struct CalendarCore: CXCalendarCoreProtocol {
    let mode: CXCalendarMode

    let scrollStrategy: CXCalendarScrollStrategy

    let calendar: Calendar

    let startDate: Date

    let selectedDate: Date
}
