//
//  CalendarMonthMiniItem.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/14/25.
//

import CXUICore
import SwiftUI

// MARK: - CalendarMonthMiniItem

struct CalendarMonthMiniItem: CXCalendarItemViewRepresentable {
    @Environment(CXCalendarCoordinator.self) var coordinator

    let dateInterval: DateInterval

    let date: CXIndexedDate

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(date.value, format: .dateTime.month())
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            MiniPage(date: date.value)
                .drawingGroup()
        }
        .frame(maxWidth: .infinity)
        .frame(height: coordinator.sizeCoordinator.itemHeight)
    }
}

// MARK: CalendarMonthMiniItem.MiniItem

extension CalendarMonthMiniItem {
    struct MiniPage: CXCalendarViewRepresentable {
        // MARK: Internal

        @Environment(CXCalendarCoordinator.self) var coordinator: CXCalendarCoordinator

        let date: Date
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: .zero),
            count: Int(CXCalendarMode.month.numOfCols)
        )

        var body: some View {
            LazyVGrid(columns: columns, spacing: CXSpacing.halfX) {
                ForEach(items) { item in
                    MiniItem(dateInterval: interval, date: item)
                }
            }
        }

        // MARK: Private

        private var interval: DateInterval {
            coordinator.dateInterval(for: date, .month)
        }

        private var items: [CXIndexedDate] {
            coordinator.items(for: interval, .month, .page)
        }
    }

    struct MiniItem: CXCalendarItemViewRepresentable {
        @Environment(CXCalendarCoordinator.self) var coordinator

        let dateInterval: DateInterval

        let date: CXIndexedDate

        var body: some View {
            Text(date.value, format: .dateTime.day())
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(isInRange ? .primary : .clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
