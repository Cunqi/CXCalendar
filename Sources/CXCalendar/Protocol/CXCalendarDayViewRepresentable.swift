//
//  CXCalendarDayViewRepresentable.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import SwiftUI

/// /// The `CXCalendarDayViewRepresentable` protocol defines the requirements for a view that represents a single day in the calendar.
public protocol CXCalendarDayViewRepresentable: CXCalendarViewRepresentable {
    /// The date interval that currently being displayed
    var dateInterval: DateInterval { get }

    /// The date that represents the day being displayed in the view.
    var date: CXIndexedDate { get }

    /// Tell whether the `day` is in some sort of range, such as the current month or week.
    /// this can be calculated by leveraging the `dateInterval` property.
    var isInRange: Bool { get }

    /// A Boolean value indicating whether the day is startDate.
    var isStartDate: Bool { get }

    /// The date value of the day being represented.
    var day: Date { get }
}

public extension CXCalendarDayViewRepresentable {
    var isInRange: Bool {
        dateInterval.containsExceptEnd(date.value, calendar)
    }

    var isStartDate: Bool {
        calendar.isSameDay(date.value, startDate)
    }

    var day: Date {
        date.value
    }
}
