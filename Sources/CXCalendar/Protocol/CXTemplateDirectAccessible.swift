//
//  CXTemplateDirectAccessible.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import Foundation

// MARK: - CXContextAccessible

/// This protocol provides access to the calendar template, layout, compose,
/// interaction components of the CXCalendarTemplate.
@MainActor
public protocol CXTemplateDirectAccessible {
    /// The calendar template that contains the configuration and state of the calendar.
    var template: CXCalendarTemplate { get }
}

extension CXTemplateDirectAccessible {
    public var core: any CXCalendarCoreProtocol {
        template.core
    }

    public var layout: any CXCalendarLayoutProtocol {
        template.layout
    }

    public var compose: any CXCalendarComposeProtocol {
        template.compose
    }

    public var interaction: any CXCalendarInteractionProtocol {
        template.interaction
    }
}
