//
//  WeekHeaderView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/15/25.
//

import SwiftUI

struct WeekHeaderView: CXCalendarHeaderViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        LazyVGrid(columns: manager.columns, spacing: manager.context.rowPadding) {
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
