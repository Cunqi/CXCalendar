//
//  CalendarWithExternalMonthHeaderViewExample.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXFoundation
import SwiftUI

// MARK: - CalendarWithExternalMonthHeaderViewExampleView

struct CalendarWithExternalMonthHeaderViewExampleView: View {
    // MARK: Internal

    var body: some View {
        let context = CXCalendarContext.paged
            .builder
            .calendarHeader { month in
                WeekdayOnlyHeaderView(month: month)
            }
            .onMonthChanged { month in
                currentMonth = month
            }
            .build()

        CXPagedCalendar(context: context, backToToday: $resetToday)
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .title) {
                    CustomNavHeaderView(month: $currentMonth)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        resetToday.toggle()
                    } label: {
                        Text("Reset")
                    }
                }
            }
    }

    // MARK: Private

    @State private var currentMonth = Date()
    @State private var resetToday = false
}

// MARK: - WeekdayOnlyHeaderView

struct WeekdayOnlyHeaderView: CXCalendarHeaderViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        HStack(spacing: layout.columnPadding) {
            let titles = calendar.veryShortWeekdaySymbols
            ForEach(titles.indices, id: \.self) { index in
                Text(titles[index])
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: - CustomNavHeaderView

struct CustomNavHeaderView: View {
    // MARK: Internal

    @Binding var month: Date

    var body: some View {
        VStack {
            monthText
            yearText
        }
    }

    // MARK: Private

    private var monthText: some View {
        Text(month.fullMonth)
            .font(.headline)
            .bold()
            .foregroundColor(.primary)
    }

    private var yearText: some View {
        Text(month.year)
            .font(.body)
            .foregroundColor(.secondary)
    }
}

#Preview {
    CalendarWithExternalMonthHeaderViewExampleView()
}
