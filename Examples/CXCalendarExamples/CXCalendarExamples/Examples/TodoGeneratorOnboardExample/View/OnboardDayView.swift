//
//  OnboardDayView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/21/25.
//

import CXCalendar
import CXUICore
import SwiftUI

struct OnboardDayView: CXCalendarDayViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager
    @Environment(TodoGeneratorOnboardViewModel.self) var viewModel

    var dateInterval: DateInterval

    var day: Date

    var body: some View {
        if isInRange {
            dayView
        } else {
            Color.clear
        }
    }

    // MARK: Private

    private var dayView: some View {
        Text(day, format: .dateTime.day())
            .font(font)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: layout.rowHeight)
            .background { background }
            .onTapGesture {
                withAnimation {
                    viewModel.pick(date: day)
                }
            }
    }

    private var background: some View {
        if !isSelected {
            return MaskedRoundedRectangle(cornerRadius: .zero)
                .fill(.clear)
        } else {
            var corners: UIRectCorner = []

            if isFirstDate || isMonthStart || isSunday {
                corners.insert(.topLeft)
                corners.insert(.bottomLeft)
            }

            if isLastDate || isMonthEnd || isSaturday {
                corners.insert(.topRight)
                corners.insert(.bottomRight)
            }

            return MaskedRoundedRectangle(cornerRadius: CXSpacing.oneX, corners: corners)
                .fill(.blue.opacity(0.2))
        }
    }

    private var font: Font {
        isStartDate ? .body.bold() : .body
    }

    private var isFirstDate: Bool {
        if let startDate = viewModel.interval?.start {
            return calendar.isSameDay(day, startDate)
        }
        return false
    }

    private var isLastDate: Bool {
        if let endDate = viewModel.interval?.end {
            return calendar.isSameDay(day, endDate)
        }
        return false
    }

    private var isSelected: Bool {
        viewModel.isInRange(day)
    }

    private var isSunday: Bool {
        calendar.component(.weekday, from: day) == 1
    }

    private var isSaturday: Bool {
        calendar.component(.weekday, from: day) == 7
    }

    private var isMonthStart: Bool {
        let startOfMonth = calendar.startOfMonth(for: day)
        return calendar.isSameDay(day, startOfMonth)
    }

    private var isMonthEnd: Bool {
        guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: day) else {
            return false
        }
        let startOfNextMonth = calendar.startOfMonth(for: nextMonth)
        guard let endOfThisMonth = calendar.date(byAdding: .day, value: -1, to: startOfNextMonth)
        else {
            return false
        }
        return calendar.isSameDay(day, endOfThisMonth)
    }
}
