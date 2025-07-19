//
//  CXDayViewRepresentable.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import SwiftUI

public protocol CXDayViewRepresentable: View, CXCalendarAccessible, CXContextAccessible {
    var dateInterval: DateInterval { get }

    var day: Date { get }

    var isInRange: Bool { get }

    var isToday: Bool { get }
}
