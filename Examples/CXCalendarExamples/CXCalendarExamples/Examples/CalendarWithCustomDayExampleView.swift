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
        let context = CXCalendarContext.month(.page)
            .builder
            .dayView { dateInterval, day in
                CustomDayView(dateInterval: dateInterval, day: day)
            }
            .build()

        CXCalendar(context: context)
            .navigationTitle("Custom Day View")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - CustomDayView

struct CustomDayView: CXDayViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let dateInterval: DateInterval

    let day: Date

    let isInRange = true

    var isToday: Bool {
        calendar.isDateInToday(day)
    }

    var body: some View {
        Text(day.day)
            .font(.body)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(backgroundColor)
            )
            .onTapGesture {
                guard interaction.canSelect(dateInterval, day, calendar) else {
                    return
                }
                withAnimation {
                    manager.selectedDate = isSelected ? nil : day
                }
            }
    }

    var backgroundColor: Color {
        if isSelected {
            .accentColor.opacity(0.5)
        } else if isToday {
            .green.opacity(0.2)
        } else {
            .clear
        }
    }

    var isSelected: Bool {
        interaction.isSelected(day, selectedDate, calendar)
    }
}
