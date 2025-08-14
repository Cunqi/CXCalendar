//
//  CXWeekOnlyCalendarHeader.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/15/25.
//

import SwiftUI

/// The `CXWeekOnlyCalendarHeader` is a view that displays the header of a calendar week.
/// It shows the abbreviated names of the weekdays in a grid layout.
/// This is the default header view used in the calendar.
struct CXWeekOnlyCalendarHeader: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarCoordinator.self) var coordinator: CXCalendarCoordinator

    var body: some View {
        LazyVGrid(columns: layout.columns, spacing: coordinator.layout.hPadding) {
            ForEach(weekSymbols.indices, id: \.self) { index in
                makeItemView(weekSymbols[index], at: index)
            }
        }
    }

    // MARK: Private

    private var weekSymbols: [String] {
        calendar.veryShortWeekdaySymbols
    }

    private func foregroundColor(for index: Int) -> Color {
        let isWeekend = 1 ... 5 ~= index
        return isWeekend ? .primary : .secondary
    }

    private func makeItemView(_ symbol: String, at index: Int) -> some View {
        Text(symbol)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(foregroundColor(for: index))
            .frame(maxWidth: .infinity)
    }
}
