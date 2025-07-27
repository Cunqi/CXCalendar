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

    var months: [CXIndexedDate] {
        manager.makeMonths(for: date)
    }

    var body: some View {
        VStack(spacing: layout.rowPadding) {
            if let bodyHeader = compose.bodyHeader {
                bodyHeader(date)
                    .erased
                    .maybe(context.calendarType.scrollBehavior == .scroll) {
                        $0.frame(height: layout.bodyHeaderHeight)
                    }
            }

            LazyVGrid(columns: columns, spacing: layout.rowPadding) {
                ForEach(months) { month in
                    CalendarYearlyBodyContentView(month: month.value)
                        .maybe(context.calendarType.scrollBehavior == .scroll) {
                            $0.frame(height: layout.rowHeight)
                        }
                        .id(month.id)
                }
            }
        }
    }

    // MARK: Private

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: CXSpacing.oneX),
        count: 3
    )
}

