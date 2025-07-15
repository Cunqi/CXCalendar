//
//  DayView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI

struct DayView: View, CXDayViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date
    let day: Date

    var isInCurrentMonth: Bool {
        calendar.isSameMonthInYear(day, month)
    }

    public var isToday: Bool {
        calendar.isDateInToday(day)
    }

    public var body: some View {
        Text(numericDay)
            .font(.footnote)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(isSelected ? Color.primary : Color.clear, lineWidth: 2)
                    .padding(1)
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

    private var numericDay: String {
        String(manager.context.calendar.component(.day, from: day))
    }

    private var foregroundColor: Color {
        isInCurrentMonth ? .primary : .secondary
    }

    private var backgroundColor: Color {
        if isToday {
            return .accentColor.opacity(0.5)
        }
        return isInCurrentMonth ? Color.green.opacity(0.1) : Color.clear
    }

    private var isSelected: Bool {
        manager.context.isSelected(day, manager.selectedDate, calendar)
    }
}
