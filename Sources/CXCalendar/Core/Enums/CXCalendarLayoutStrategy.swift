//
//  CXCalendarLayoutStrategy.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/15/25.
//

import Foundation

/// The `CXCalendarLayoutStrategy` enum defines the layout strategy of the calendar.
public enum CXCalendarLayoutStrategy: Equatable {
    /// The calendar layout strategy is relying on the layout of the calendar item.
    case wrap

    /// The calendar layout strategy is trying to take as much space as possible.
    case flex
}
