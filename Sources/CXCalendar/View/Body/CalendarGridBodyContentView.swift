//
//  CalendarGridBodyContentView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXFoundation
import SwiftUI

struct CalendarGridBodyContentView: CXCalendarBodyContentViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let date: Date

    var body: some View {
        LazyVGrid(columns: manager.columns, spacing: layout.rowPadding) {
            ForEach(days) { day in
                compose.dayView(dateInterval, day.value).erased
            }
        }
    }

    var dateInterval: DateInterval {
        manager.makeDateInterval(for: date)
    }

    var days: [IdentifiableDate] {
        manager.makeBodyGridDates(from: dateInterval)
    }
}
