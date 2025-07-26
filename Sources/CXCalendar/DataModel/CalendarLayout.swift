//
//  CalendarLayout.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

// MARK: - CXCalendarLayoutProtocol

public protocol CXCalendarLayoutProtocol {
    /// Orientation of the calendar axis (horizontal or vertical).
    var axis: Axis { get }

    /// Padding between each column of days.
    var columnPadding: CGFloat { get }

    /// Padding between each row of days.
    var rowPadding: CGFloat { get }

    /// Height of the header that displays the header content (e.g., month name).
    var bodyHeaderHeight: CGFloat { get }

    /// Height of each row of month view. it is only used for scrollable calendar.
    var rowHeight: CGFloat { get }

    /// Horizontal padding between the calendar and the edges of the screen.
    var calendarHPadding: CGFloat { get }
}

// MARK: - CalendarLayout

struct CalendarLayout: CXCalendarLayoutProtocol {
    let axis: Axis

    let columnPadding: CGFloat

    let rowPadding: CGFloat

    let bodyHeaderHeight: CGFloat

    let rowHeight: CGFloat

    let calendarHPadding: CGFloat
}
