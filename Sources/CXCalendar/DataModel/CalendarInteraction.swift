//
//  CalendarInteraction.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

// MARK: - Typealias

public typealias CanSelectAction = (DateInterval, Date, Calendar) -> Bool

public typealias IsSelectedAction = (Date, Date?, Calendar) -> Bool

public typealias OnSelectedAction = (Date?) -> Void

public typealias OnMonthChangedAction = (Date) -> Void

// MARK: - CXCalendarInteractionProtocol

public protocol CXCalendarInteractionProtocol {
    /// Closure to tell if given date can be selected
    var canSelect: CanSelectAction { get }

    /// Closure to tell if given date is selected
    var isSelected: IsSelectedAction { get }

    /// Boolean indicating whether to hide non-current month days in the calendar.
    var shouldHideWhenOutOfBounds: Bool { get }

    /// Callback triggered when a date is selected or deselected.
    var onSelected: OnSelectedAction? { get }

    /// Callback triggered when the month is changed.
    var onMonthChanged: OnMonthChangedAction? { get }
}

// MARK: - CalendarInteraction

struct CalendarInteraction: CXCalendarInteractionProtocol {
    let canSelect: CanSelectAction

    let isSelected: IsSelectedAction

    let shouldHideWhenOutOfBounds: Bool

    let onSelected: OnSelectedAction?

    let onMonthChanged: OnMonthChangedAction?
}
