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
        let context = CXCalendarCoordinator.month(.page)
            .builder
            .dayView { dateInterval, day, _ in
                CustomDayView(dateInterval: dateInterval, date: day)
            }
            .build()

        CXCalendarView(context: context)
            .navigationTitle("Custom Day View")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - CustomDayView

struct CustomDayView: CXCalendarDayViewRepresentable {
    @Environment(CXCalendarCoordinator.self) var coordinator

    let dateInterval: DateInterval

    let date: CXIndexedDate

    var body: some View {
        Text(day.day)
            .font(font)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(
                Circle()
                    .fill(backgroundColor)
            )
            .onTapGesture {
                guard interaction.canSelect(dateInterval, date.value, calendar) else {
                    return
                }
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
        interaction.isSelected(date.value, selectedDate, calendar)
    }
}
