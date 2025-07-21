//
//  MonthHeaderView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

/// The `MonthHeaderView` is a view that displays the header for a month in the calendar.
/// It shows the full month name and the year in a horizontal stack.
/// This is the default header view used in the calendar.
struct MonthHeaderView: CXCalendarViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        HStack {
            Text(month.fullMonth)
                .font(.headline)
                .foregroundColor(.primary)
            Text(month.year)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
