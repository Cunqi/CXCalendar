//
//  CalendarInteraction.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

public protocol CXCalendarInteractionProtocol {
    /// Closure to tell if given date can be selected
    var canSelect: (Date, Date, Calendar) -> Bool { get }

    /// Closure to tell if given date is selected
    var isSelected: (Date, Date?, Calendar) -> Bool { get }

    /// Boolean indicating whether to hide non-current month days in the calendar.
    var shouldHideNonCurrentMonthDays: Bool { get }

    /// Callback triggered when a date is selected or deselected.
    var onSelected: ((Date?) -> Void)? { get }

    /// Callback triggered when the month is changed.
    var onMonthChanged: ((Date) -> Void)? { get }
}

struct CalendarInteraction: CXCalendarInteractionProtocol {

    let canSelect: (Date, Date, Calendar) -> Bool

    let isSelected: (Date, Date?, Calendar) -> Bool

    let shouldHideNonCurrentMonthDays: Bool

    let onSelected: ((Date?) -> Void)?

    let onMonthChanged: ((Date) -> Void)?
}
