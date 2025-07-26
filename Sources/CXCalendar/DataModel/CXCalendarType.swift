//
//  CXCalendarType.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/18/25.
//

import Foundation

// MARK: - CXCalendarType

/// The `CXCalendarType` enum defines the type of calendar being used,
/// either a month or a week view, along with its scrolling behavior, if applicable.
public enum CXCalendarType: Equatable {
    /// A year view calendar with a specified scrolling behavior.
    case year(CXCalendarScrollBehavior)
    /// A month view calendar with a specified scrolling behavior.
    case month(CXCalendarScrollBehavior)

    /// A week view calendar. with a default scrolling behavior of `.page`.
    case week
}

extension CXCalendarType {
    /// Returns the component type for the current calendar type.
    /// this component will be used for date calculations.
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

    /// Returns if the calendar type is a week view.
    var isWeek: Bool {
        switch self {
        case .week:
            true
        case .month:
            false
        case .year:
            false
        }
    }

    /// Returns the scroll behavior for the current calendar type.
    var scrollBehavior: CXCalendarScrollBehavior {
        switch self {
        case .year(let scrollBehavior):
            scrollBehavior
        case .month(let scrollBehavior):
            scrollBehavior
        case .week:
            .page
        }
    }
}
