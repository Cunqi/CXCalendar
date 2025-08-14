//
//  CXCalendarItemViewRepresentable.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import SwiftUI

// MARK: - CXCalendarItemViewRepresentable

/// The `CXCalendarItemViewRepresentable` protocol defines the requirements for a view that represents a single item in the calendar.
public protocol CXCalendarItemViewRepresentable: CXCalendarViewRepresentable {
    /// The date interval that date of the item belongs to
    var dateInterval: DateInterval { get }

    /// The date that represents the item being displayed in the view.
    var date: CXIndexedDate { get }

    /// Tell whether the `day` is in some sort of range, such as the current month or week.
    var isInRange: Bool { get }

    /// A Boolean value indicating whether the day is startDate.
    var isStartDate: Bool { get }
}

extension CXCalendarItemViewRepresentable {
    public var isInRange: Bool {
        dateInterval.containsExceptEnd(date.value, calendar)
    }

    public var isStartDate: Bool {
        calendar.isSameDay(date.value, startDate)
    }
}
