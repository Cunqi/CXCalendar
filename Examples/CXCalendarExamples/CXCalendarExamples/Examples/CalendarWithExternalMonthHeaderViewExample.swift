//
//  CalendarWithExternalMonthHeaderViewExample.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXFoundation
import SwiftUI

struct CalendarWithExternalMonthHeaderViewExampleView: View {
    @State private var currentMonth: Date = Date()
    @State private var resetToday: Bool = false

    var body: some View {
        let context = CXCalendarContext.paged.builder
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
}

struct WeekdayOnlyHeaderView: CXCalendarHeaderViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        HStack(spacing: manager.context.columnPadding) {
            let titles = manager.context.weekdayTitles
            ForEach(titles.indices, id: \.self) { index in
                Text(titles[index])
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct CustomNavHeaderView: View {
    @Binding var month: Date

    var body: some View {
        VStack {
            monthText
            yearText
        }
    }

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
