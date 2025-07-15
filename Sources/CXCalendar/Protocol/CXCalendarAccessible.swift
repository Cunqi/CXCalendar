//
//  File.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

@MainActor
public protocol CXCalendarAccessible {
    var manager: CXCalendarManager { get }

    var calendar: Calendar { get }

    var startDate: Date { get }

    var currentDate: Date { get }

    var selectedDate: Date? { get }
}

public extension CXCalendarAccessible {
    var calendar: Calendar {
        manager.context.calendar
    }

    var startDate: Date {
        manager.startDate
    }

    var currentDate: Date {
        manager.currentDate
    }

    var selectedDate: Date? {
        manager.selectedDate
    }
}
