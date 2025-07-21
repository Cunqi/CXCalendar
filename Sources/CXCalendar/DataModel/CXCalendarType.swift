//
//  CXCalendarType.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/18/25.
//

import Foundation

// MARK: - CXCalendarType

public enum CXCalendarType {
    case month(CXCalendarScrollBehavior)

    case week
}

extension CXCalendarType {
    var component: Calendar.Component {
        switch self {
        case .month:
            .month
        case .week:
            .weekOfYear
        }
    }

    var offsetComponent: Calendar.Component {
        switch self {
        case .month:
            .day
        case .week:
            .day
        }
    }

    var isWeek: Bool {
        switch self {
        case .week:
            true
        case .month:
            false
        }
    }
}

extension CXCalendarType {
    var scrollBehavior: CXCalendarScrollBehavior {
        switch self {
        case .month(let scrollBehavior):
            scrollBehavior
        case .week:
            .page
        }
    }
}
