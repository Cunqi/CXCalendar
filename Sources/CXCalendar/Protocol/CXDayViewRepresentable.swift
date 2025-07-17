//
//  CXDayViewRepresentable.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import SwiftUI

public protocol CXDayViewRepresentable: View, CXCalendarAccessible, CXContextAccessible {

    var month: Date { get }

    var day: Date { get }

    var isInCurrentMonth: Bool { get }

    var isToday: Bool { get }
}
