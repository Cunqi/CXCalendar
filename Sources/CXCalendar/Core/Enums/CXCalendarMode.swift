//
//  CXCalendarMode.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import Foundation

// MARK: - CXCalendarMode

/// The `CXCalendarMode` enum defines the mode of the calendar.
public enum CXCalendarMode: Int, CaseIterable {
    /// The calendar is in year mode. in this mode the calendar will show a year view,
    /// contains 12 months in mini month view.
    case year
    /// The calendar is in month mode. in this mode the calendar will show a month view,
    /// contains a whole month view.
    case month
    /// The calendar is in week mode. in this mode the calendar will show a week view,
    /// contains 7 days.
    case week
}

extension CXCalendarMode {
    var component: Calendar.Component {
        switch self {
        case .year:
            .year
        case .month:
            .month
        case .week:
            .weekOfYear
        }
    }
}
