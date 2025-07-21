//
//  CXCalendarBodyContentViewRepresentable.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import SwiftUI

/// /// The `CXCalendarBodyContentViewRepresentable` protocol defines a view that can represent the body content of a calendar.
public protocol CXCalendarBodyContentViewRepresentable: CXCalendarViewRepresentable {
    /// The date for which the body content is being represented.
    var date: Date { get }
}
