//
//  CXCalendarBodyViewRepresentable.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/25/25.
//

import SwiftUI

/// `CXCalendarBodyViewRepresentable` is a protocol that defines the requirements for a calendar body view.
public protocol CXCalendarBodyViewRepresentable: CXCalendarViewRepresentable {
    var date: Date { get }
}
