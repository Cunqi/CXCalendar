//
//  CalendarPageHeader.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/14/25.
//

import CXUICore
import SwiftUI

struct CalendarPageHeader: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarCoordinator.self) var coordinator

    let date: Date

    var body: some View {
        switch core.mode {
        case .year:
            yearlyHeader
        case .month:
            monthlyHeader
        case .week:
            EmptyView()
        }
    }

    // MARK: Private

    private var weekdayOfDate: Int {
        switch core.mode {
        case .month:
            let startOfMonth = core.calendar.startOfMonth(for: date)
            return (core.calendar.component(.weekday, from: startOfMonth) + 6) % 7

        case .year, .week:
            return 0
        }
    }

    @ViewBuilder
    private var monthlyHeader: some View {
        VStack {
            Spacer()
            LazyVGrid(columns: layout.columns, spacing: .zero) {
                ForEach(0 ..< 7) { index in
                    if index == weekdayOfDate {
                        Text(monthTitle)
                            .font(.body)
                            .bold()
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                    } else {
                        Color
                            .clear
                            .frame(maxWidth: .infinity)
                    }
                }
            }

            HStack {
                Color.clear
                    .frame(width: coordinator.sizeProvider
                        .calculateLeadingSpace(numOfLeadingItems: weekdayOfDate)
                    )
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.separator)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: coordinator.sizeProvider.itemHeight)
    }

    @ViewBuilder
    private var yearlyHeader: some View {
        VStack(alignment: .leading, spacing: CXSpacing.oneX) {
            Text(date, format: .dateTime.year())
                .font(.title)
                .bold()
                .foregroundColor(.primary)
            Divider()
        }
    }

    private var monthTitle: String {
        let month = calendar.component(.month, from: date)
        return calendar.shortMonthSymbols[month - 1]
    }
}
