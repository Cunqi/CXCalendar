//
//  File.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

// MARK: - CXCalendarAccessible

@MainActor
public protocol CXCalendarAccessible {
    var manager: CXCalendarManager { get }

    var calendar: Calendar { get }

    var startDate: Date { get }

    var currentDate: Date { get }

    var currentDateInterval: DateInterval { get }

    var selectedDate: Date? { get }
}

extension CXCalendarAccessible {
    public var calendar: Calendar {
        manager.context.calendar
    }

    public var startDate: Date {
        manager.startDate
    }

    public var currentDate: Date {
        manager.currentDate
    }

    public var currentDateInterval: DateInterval {
        manager.currentDateInterval
    }

    public var selectedDate: Date? {
        manager.selectedDate
    }
}
