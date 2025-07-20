//
//  CXCalendarBodyContentViewRepresentable.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import SwiftUI

public protocol CXCalendarBodyContentViewRepresentable: CXCalendarViewRepresentable {
    var date: Date { get }
}
