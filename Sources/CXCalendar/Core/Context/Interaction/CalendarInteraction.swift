//
//  CalendarInteraction.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import Foundation

public typealias OnCalendarItemSelect = (Date) -> Void

public typealias OnAnchorDateChange = (Date) -> Void

// MARK: - CXCalendarInteractionProtocol

@MainActor
public protocol CXCalendarInteractionProtocol {
    var onCalendarItemSelect: OnCalendarItemSelect? { get }
    var onAnchorDateChange: OnAnchorDateChange? { get }
}

// MARK: - CalendarInteraction

struct CalendarInteraction: CXCalendarInteractionProtocol {
    let onCalendarItemSelect: OnCalendarItemSelect?

    let onAnchorDateChange: OnAnchorDateChange?
}
