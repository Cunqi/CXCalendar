//
//  CXContextAccessible.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import Foundation

@MainActor
public protocol CXContextAccessible {
    var manager: CXCalendarManager { get }

    var context: CXCalendarContext { get }

    var layout: CXCalendarLayoutProtocol { get }

    var compose: CXCalendarComposeProtocol { get }

    var interaction: CXCalendarInteractionProtocol { get }
}

public extension CXContextAccessible {
    var context: CXCalendarContext {
        manager.context
    }

    var layout: CXCalendarLayoutProtocol {
        context.layout
    }

    var compose: CXCalendarComposeProtocol {
        context.compose
    }

    var interaction: CXCalendarInteractionProtocol {
        context.interaction
    }
}
