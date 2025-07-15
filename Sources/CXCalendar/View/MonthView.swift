//
//  MonthView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI

struct MonthView: View, CXCalendarAccessible {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    private var days: [IdentifiableDate] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else {
            return []
        }
        return calendar.makeMonthGridDates(from: monthInterval)
    }

    // MARK: - Initializer

    var body: some View {
        LazyVGrid(columns: manager.columns, spacing: manager.context.rowPadding) {
            ForEach(days) { day in
                manager.context.dayView(month, day.value).erased
            }
        }

        if let accessoryView = manager.context.accessoryView,
           let selectedDate = manager.selectedDate {
            accessoryView(selectedDate).erased
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
}

