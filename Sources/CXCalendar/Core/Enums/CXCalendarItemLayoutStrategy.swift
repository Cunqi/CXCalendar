//
//  CXCalendarLayoutStrategy.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//
import Foundation

/// The `CXCalendarLayoutStrategy` enum defines the layout strategy of the calendar
public enum CXCalendarLayoutStrategy: Equatable {
    /// The calendar layout strategy is trying to make the width and height of the calendar item equal.
    case equalWidth

    /// The calendar layout strategy is trying to use the fixed height and the flexible width.
    case fixedHeight(CGFloat)

    /// The calendar layout strategy is trying to use the flexible height and the flexible width.
    /// It will always try to take as much space as possible and split the space evenly.
    case flexHeight
}
