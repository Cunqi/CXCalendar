//
//  CalendarYearlyBodyView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/25/25.
//

import CXUICore
import SwiftUI

struct CalendarYearlyBodyView: CXCalendarBodyViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let date: Date

    var months: [IndexedDate] {
        manager.makeMonths(for: date)
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: CXSpacing.threeX) {
            ForEach(months) { month in
                CalendarYearlyBodyContentView(month: month.value)
            }
        }
    }

    // MARK: Private

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: CXSpacing.oneX),
        count: 3
    )
}
