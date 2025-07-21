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
            .dayView { dateInterval, day, _ in
                CustomDayView(dateInterval: dateInterval, day: day)
            }
            .build()

        CXCalendarView(context: context)
            .navigationTitle("Custom Day View")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - CustomDayView

struct CustomDayView: CXCalendarDayViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let dateInterval: DateInterval

    let day: Date

    var isInRange: Bool {
        dateInterval.containsExceptEnd(day, calendar)
    }

    var isStartDate: Bool {
        calendar.isDate(day, inSameDayAs: startDate)
    }

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
                guard interaction.canSelect(dateInterval, day, calendar) else {
                    return
                }
                withAnimation {
                    manager.selectedDate = day
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
        interaction.isSelected(day, selectedDate, calendar)
    }
}
