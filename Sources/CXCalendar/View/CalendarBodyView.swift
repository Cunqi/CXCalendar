//
//  CalendarBodyView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI

struct CalendarBodyView: View, CXCalendarAccessible, CXContextAccessible {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let date: Date

    var dateInterval: DateInterval {
        manager.makeDateInterval(for: date)
    }

    // MARK: - Initializer

    var body: some View {
        VStack(spacing: layout.rowPadding) {
            if let bodyHeader = compose.bodyHeader {
                bodyHeader(date)
                    .frame(height: layout.rowHeight)
                    .frame(maxWidth: .infinity)
                    .erased
            }

            LazyVGrid(columns: manager.columns, spacing: layout.rowPadding) {
                ForEach(days) { day in
                    compose.dayView(date, day.value).erased
                }
            }

            if let accessoryView = compose.accessoryView, let selectedDate = manager.selectedDate {
                accessoryView(selectedDate)
                    .erased
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    // MARK: Private

    private var days: [IdentifiableDate] {
        manager.makeMonthGridDates(from: dateInterval)
    }
}
