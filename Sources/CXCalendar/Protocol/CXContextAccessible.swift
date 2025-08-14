//
//  CXContextAccessible.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import Foundation

// MARK: - CXContextAccessible

/// This protocol provides access to the calendar context, layout, compose,
/// interaction components of the CXCalendarContext.
@MainActor
public protocol CXContextAccessible {
    /// The calendar context that contains the configuration and state of the calendar.
    var context: CXCalendarContext { get }
}

extension CXContextAccessible {
    public var core: any CXCalendarCoreProtocol {
        context.core
    }

    public var layout: any CXCalendarLayoutProtocol {
        context.layout
    }

    public var compose: any CXCalendarComposeProtocol {
        context.compose
    }

    public var interaction: any CXCalendarInteractionProtocol {
        context.interaction
    }
}
