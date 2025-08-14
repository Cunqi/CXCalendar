//
//  CXCalendarScrollStrategy.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import Foundation

/// The `CXCalendarScrollStrategy` enum defines the scroll strategy of the calendar.
public enum CXCalendarScrollStrategy: Int {
    /// The calendar scrolls continuously, allowing users to scroll through dates seamlessly.
    case scroll

    /// The calendar scrolls in pages, where each page represents a complete date range.
    case page
}
