//
//  CalendarWithCustomHeaderExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXUICore
import SwiftUI

// MARK: - CalendarWithCustomHeaderExampleView

struct CalendarWithCustomHeaderExampleView: View {
    var body: some View {
        let context = CXCalendarContext.paged
            .builder
            .calendarHeader { month in
                CustomMonthHeaderView(month: month)
            }
            .build()

        CXPagedCalendar(context: context)
            .padding(.horizontal)
            .padding(.horizontal)
            .navigationTitle("Calendar with Custom Header")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - CustomMonthHeaderView

struct CustomMonthHeaderView: CXCalendarHeaderViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    monthText
                    yearText
                }

                Spacer()

                if manager.shouldDisplayResetToTodayButton(month: month) {
                    resetToTodayButton
                }
            }
            Divider()
        }
    }

    // MARK: Private

    private var monthText: some View {
        Text(month.fullMonth)
            .font(.headline)
            .bold()
            .foregroundColor(monthTextForegroundColor)
    }

    private var yearText: some View {
        Text(month.year)
            .font(.body)
            .foregroundColor(.secondary)
    }

    private var monthTextForegroundColor: Color {
        let isCurrentMonth = calendar.isSameMonthInYear(month, startDate)
        return isCurrentMonth ? .primary : .secondary
    }

    private var resetToTodayButton: some View {
        Button {
            withAnimation {
                manager.resetToToday()
            }
        } label: {
            Image(systemName: "t.square.fill")
                .font(.title2)
                .foregroundColor(.accentColor)
        }
    }
}

#Preview {
    CalendarWithCustomHeaderExampleView()
}
