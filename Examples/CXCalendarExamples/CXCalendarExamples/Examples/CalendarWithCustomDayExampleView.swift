//
//  CalendarWithCustomDayExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXUICore
import SwiftUI

// MARK: - CalendarWithCustomDayExampleView

struct CalendarWithCustomDayExampleView: View {
    var body: some View {
        let template = CXCalendarTemplate.month(.page)
            .builder
            .calendarItem { dateInterval, day in
                CustomDayView(dateInterval: dateInterval, date: day)
            }
            .build()

        CXCalendarView(template: template)
            .navigationTitle("Custom Day View")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - CustomDayView

struct CustomDayView: CXCalendarItemViewRepresentable {
    @Environment(CXCalendarCoordinator.self) var coordinator

    let dateInterval: DateInterval

    let date: CXIndexedDate

    var body: some View {
        Text(date.value, format: .dateTime.day())
            .font(font)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(
                Circle()
                    .fill(backgroundColor)
            )
            .onTapGesture {
                withAnimation {
                    coordinator.selectedDate = date.value
                }
            }
    }

    var font: Font {
        isStartDate ? .body.bold() : .body
    }

    var backgroundColor: Color {
        isSelected ? .accentColor.opacity(0.5) : .clear
    }

    var isSelected: Bool {
        coordinator.isDateSelected(date.value)
    }
}
