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
        let template = CXCalendarTemplate.month(.page)
            .builder
            .calendarHeader { date in
                CustomMonthHeaderView(date: date)
            }
            .build()

        CXCalendarView(template: template)
            .navigationTitle("Calendar with Custom Header")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
    }
}

// MARK: - CustomMonthHeaderView

struct CustomMonthHeaderView: CXCalendarViewRepresentable {
    @Environment(CXCalendarCoordinator.self) var coordinator

    var date: Date

    var body: some View {
        HStack {
            Text("Current Month:")
                .font(.headline)
                .foregroundColor(.primary)
            Text(date, format: .dateTime.month().year())
                .font(.headline)
                .bold()
                .foregroundColor(.primary)
            Spacer()

            resetButton
        }
    }

    @ViewBuilder
    private var resetButton: some View {
        if coordinator.isCalendarChanged {
            Button("Reset") {
                coordinator.reset()
            }
        }
    }
}
