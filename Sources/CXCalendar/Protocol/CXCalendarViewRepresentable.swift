//
//  CXCalendarViewRepresentable.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import SwiftUI

/// The `CXCalendarViewRepresentable` protocol defines a SwiftUI view that can represent
/// a calendar component view
public protocol CXCalendarViewRepresentable: View, CXCalendarCoodinatorAccessible, CXContextAccessible { }
