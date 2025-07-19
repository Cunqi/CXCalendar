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
