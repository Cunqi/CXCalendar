//
//  CXCalendarScrollBehavior.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/19/25.
//

import Foundation

/// /// The `CXCalendarScrollBehavior` enum defines the scrolling behavior of the calendar.
public enum CXCalendarScrollBehavior: Int {
    /// The calendar scrolls continuously, allowing users to scroll through dates seamlessly.
    case scroll

    /// The calendar scrolls in pages, where each page represents a complete month or week.
    case page
}
