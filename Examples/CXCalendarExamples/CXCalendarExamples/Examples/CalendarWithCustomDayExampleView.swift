//
//  CalendarWithCustomDayExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXUICore
import SwiftUI

struct CalendarWithCustomDayExampleView: View {
    var body: some View {
        let context = CXCalendarContext.paged.builder
            .dayView { month, day in
                CustomDayView(month: month, day: day)
            }
            .build()

        CXCalendarView(context: context)
            .padding(.horizontal)
            .navigationTitle("Custom Day View")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomDayView: CXDayViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    let day: Date

    let isInCurrentMonth: Bool = true

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
                guard manager.context.canSelect(month, day, calendar) else {
                    return
                }
                withAnimation {
                    manager.selectedDate = isSelected ? nil : day
                }
            }
    }

    var backgroundColor: Color {
        if isSelected {
            return .accentColor.opacity(0.5)
        } else if isToday {
            return .green.opacity(0.2)
        } else {
            return .clear
        }
    }

    var isSelected: Bool {
        manager.context.isSelected(day, selectedDate, calendar)
    }
}
