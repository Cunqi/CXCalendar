//
//  CXCalendarCoodinatorAccessible.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

// MARK: - CXCalendarCoodinatorAccessible

/// This protocol defines the properties and methods that provide access to the calendar's state and configuration.
@MainActor
public protocol CXCalendarCoodinatorAccessible {
    /// The calendar manager that handles the calendar view's data and behavior.
    var coordinator: CXCalendarCoordinator { get }
}

/// Extension to provide default implementations for the `CXCalendarCoodinatorAccessible` protocol properties.
extension CXCalendarCoodinatorAccessible {
    public var context: CXCalendarContext {
        coordinator.context
    }

    public var calendar: Calendar {
        context.core.calendar
    }

    public var startDate: Date {
        context.core.startDate
    }

    public var currentAnchorDate: Date {
        coordinator.currentAnchorDate
    }

    public var selectedDate: Date {
        coordinator.selectedDate
    }
}
