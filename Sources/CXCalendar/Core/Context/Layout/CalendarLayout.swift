//
//  CalendarLayout.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

// MARK: - CXCalendarLayoutProtocol

@MainActor
public protocol CXCalendarLayoutProtocol {
    /// Orientation of the calendar axis (horizontal or vertical).
    var axis: Axis { get }

    /// Horizontal padding between calendar columns.
    var hPadding: CGFloat { get }

    /// Vertical padding between each calendar rows.
    var vPadding: CGFloat { get }

    /// The columns of the calendar grid.
    var columns: [GridItem] { get }

    /// The layout strategy of the calendar item.
    var layoutStrategy: CXCalendarLayoutStrategy { get }
}

// MARK: - CalendarLayout

struct CalendarLayout: CXCalendarLayoutProtocol {
    let axis: Axis

    let hPadding: CGFloat

    let vPadding: CGFloat

    let columns: [GridItem]

    let layoutStrategy: CXCalendarLayoutStrategy
}
