//
//  File.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

// MARK: - CXCalendarAccessible

/// This protocol defines the properties and methods that provide access to the calendar's state and configuration.
@MainActor
public protocol CXCalendarAccessible {
    /// The calendar manager that handles the calendar view's data and behavior.
    var manager: CXCalendarManager { get }

    /// The calendar used for date calculations and formatting.
    var calendar: Calendar { get }

    /// The start date of the calendar, representing the first date displayed in the calendar view.
    var startDate: Date { get }

    /// The current anchor date of the calendar, which is typically the date offset from the start date
    /// based on the `currentPage`
    var currentAnchorDate: Date { get }

    /// The current date interval of the calendar, representing the range of dates currently displayed.
    var currentDateInterval: DateInterval { get }

    /// The selected date in the calendar, which is the date currently highlighted or focused.
    var selectedDate: Date { get }
}

/// Extension to provide default implementations for the `CXCalendarAccessible` protocol properties.
extension CXCalendarAccessible {
    public var calendar: Calendar {
        manager.context.calendar
    }

    public var startDate: Date {
        manager.startDate
    }

    public var currentAnchorDate: Date {
        manager.currentAnchorDate
    }

    public var currentDateInterval: DateInterval {
        manager.currentDateInterval
    }

    public var selectedDate: Date {
        manager.selectedDate
    }
}
