//
//  WeekHeaderView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/15/25.
//

import SwiftUI

/// The `WeekHeaderView` is a view that displays the header of a calendar week.
/// It shows the abbreviated names of the weekdays in a grid layout.
/// This is the default header view used in the calendar.
struct WeekHeaderView: CXCalendarViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        LazyVGrid(columns: manager.columns, spacing: layout.rowPadding) {
            let titles = calendar.veryShortWeekdaySymbols
            ForEach(titles.indices, id: \.self) { index in
                Text(titles[index])
                    .font(.caption)
                    .foregroundColor(foregroundColor(for: index))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }

    func foregroundColor(for index: Int) -> Color {
        let isWeekend = 1 ... 5 ~= index
        return isWeekend ? .primary : .secondary
    }
}
