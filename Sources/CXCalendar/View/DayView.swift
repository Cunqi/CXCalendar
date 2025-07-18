//
//  DayView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXUICore
import SwiftUI

struct DayView: View, CXDayViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let month: Date
    let day: Date

    var isInCurrentMonth: Bool {
        calendar.isSameMonthInYear(day, month)
    }

    var isToday: Bool {
        calendar.isDateInToday(day)
    }

    var body: some View {
        if interaction.shouldHideNonCurrentMonthDays, !isInCurrentMonth {
            Color.clear
        } else {
            Text(numericDay)
                .font(.footnote)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ifElse(manager.context.style == .paged) {
                    $0.aspectRatio(1, contentMode: .fit)
                } else: {
                    $0.frame(height: layout.rowHeight)
                }
                .background(
                    RoundedRectangle(cornerRadius: CXSpacing.halfX)
                        .fill(backgroundColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: CXSpacing.halfX)
                        .stroke(
                            isSelected ? Color.primary : Color.clear,
                            lineWidth: CXSpacing.quarterX
                        )
                        .padding(1)
                )
                .onTapGesture {
                    guard interaction.canSelect(month, day, calendar) else {
                        return
                    }
                    withAnimation {
                        manager.selectedDate = isSelected ? nil : day
                    }
                }
        }
    }

    // MARK: Private

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
        interaction.isSelected(day, manager.selectedDate, calendar)
    }
}
