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
    public var template: CXCalendarTemplate {
        coordinator.template
    }

    public var calendar: Calendar {
        template.core.calendar
    }

    public var startDate: Date {
        template.core.startDate
    }

    public var anchorDate: Date {
        coordinator.anchorDate
    }

    public var selectedDate: Date {
        coordinator.selectedDate
    }
}
