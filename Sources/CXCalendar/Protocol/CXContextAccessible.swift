//
//  CXContextAccessible.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import Foundation

// MARK: - CXContextAccessible

/// This protocol provides access to the calendar context, layout, compose, and interaction components of the CXCalendarManager.
@MainActor
public protocol CXContextAccessible {
    /// The calendar manager that handles the calendar view's data and behavior.
    var manager: CXCalendarManager { get }

    /// The calendar context that contains the configuration and state of the calendar.
    var context: CXCalendarContext { get }

    /// The layout configuration for the calendar, defining how the calendar's items are arranged.
    var layout: CXCalendarLayoutProtocol { get }

    /// The compose configuration for the calendar, defining how the calendar's items are composed and displayed.
    var compose: CXCalendarComposeProtocol { get }

    /// The interaction configuration for the calendar, defining how the calendar responds to user interactions.
    var interaction: CXCalendarInteractionProtocol { get }
}

extension CXContextAccessible {
    public var context: CXCalendarContext {
        manager.context
    }

    public var layout: CXCalendarLayoutProtocol {
        context.layout
    }

    public var compose: CXCalendarComposeProtocol {
        context.compose
    }

    public var interaction: CXCalendarInteractionProtocol {
        context.interaction
    }
}
