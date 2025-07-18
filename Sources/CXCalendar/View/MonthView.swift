//
//  MonthView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI

struct MonthView: View, CXCalendarAccessible, CXContextAccessible {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let month: Date

    // MARK: - Initializer

    var body: some View {
        VStack(spacing: layout.rowPadding) {
            if let monthHeader = compose.monthHeader {
                monthHeader(month)
                    .frame(height: layout.rowHeight)
                    .frame(maxWidth: .infinity)
                    .erased
            }

            LazyVGrid(columns: manager.columns, spacing: layout.rowPadding) {
                ForEach(days) { day in
                    compose.dayView(month, day.value).erased
                }
            }

            if let accessoryView = compose.accessoryView,
               let selectedDate = manager.selectedDate {
                accessoryView(selectedDate)
                    .erased
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }

    // MARK: Private

    private var days: [IdentifiableDate] {
        manager.makeMonthGridDates(for: month)
    }
}
