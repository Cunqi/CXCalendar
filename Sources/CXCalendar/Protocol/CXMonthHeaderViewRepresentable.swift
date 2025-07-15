//
//  CXMonthHeaderViewRepresentable.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import SwiftUI

public protocol CXMonthHeaderViewRepresentable: View, CXCalendarAccessible {
    var month: Date { get }
}
