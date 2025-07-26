//
//  CalendarTheme.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/25/25.
//

import SwiftUI

// MARK: - CXCalendarThemeProtocol

public protocol CXCalendarThemeProtocol {
    /// The accent color of the calendar, this will be used to render `startDate` and `selectedDate`.
    var accentColor: Color { get }

    /// The selected color of the calendar, this will be used to render `selectedDate`.
    var selectedColor: Color { get }
}

// MARK: - CalendarTheme

struct CalendarTheme: CXCalendarThemeProtocol {
    let accentColor: Color

    let selectedColor: Color
}
