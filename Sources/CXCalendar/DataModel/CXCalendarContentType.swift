//
//  CXCalendarContentType.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/18/25.
//

import Foundation

// MARK: - CXCalendarContentType

public enum CXCalendarContentType {
    case month

    case week
}

extension CXCalendarContentType {
    var component: Calendar.Component {
        switch self {
        case .month:
            .month
        case .week:
            .weekOfYear
        }
    }
}
