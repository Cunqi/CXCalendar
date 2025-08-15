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
        let template = CXCalendarTemplate.month(.page)
            .builder
            .calendarHeader { month in
                CXWeekOnlyCalendarHeader()
            }
            .build()

        CXCalendarView(template: template, anchorDate: $anchorDate)
            .toolbar {
                ToolbarItem(placement: .title) {
                    CustomNavHeaderView(month: $anchorDate)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        anchorDate = .now
                    } label: {
                        Text("Reset")
                    }
                }
            }
    }

    // MARK: Private

    @State private var anchorDate = Date()
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
