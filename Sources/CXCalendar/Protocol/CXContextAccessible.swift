//
//  CXContextAccessible.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import Foundation

// MARK: - CXContextAccessible

@MainActor
public protocol CXContextAccessible {
    var manager: CXCalendarManager { get }

    var context: CXCalendarContext { get }

    var calendarType: CXCalendarType { get }

    var layout: CXCalendarLayoutProtocol { get }

    var compose: CXCalendarComposeProtocol { get }

    var interaction: CXCalendarInteractionProtocol { get }
}

extension CXContextAccessible {
    public var context: CXCalendarContext {
        manager.context
    }

    public var calendarType: CXCalendarType {
        context.calendarType
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
