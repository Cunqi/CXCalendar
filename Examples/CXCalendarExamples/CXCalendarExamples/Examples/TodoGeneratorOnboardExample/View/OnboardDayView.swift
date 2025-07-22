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
            .aspectRatio(1, contentMode: .fit)
            .background { background }
            .onTapGesture {
                withAnimation {
                    viewModel.pick(date: day)
                }
            }
    }

    private var background: some View {
        if isFirstDate && isLastDate {
            MaskedRoundedRectangle(cornerRadius: CXSpacing.oneX)
                .fill(.blue.opacity(0.2))
        } else if isFirstDate || isSelectedAndSunday || isMonthStart {
            MaskedRoundedRectangle(cornerRadius: CXSpacing.oneX, corners: [.topLeft, .bottomLeft])
                .fill(.blue.opacity(0.2))
        } else if isLastDate || isSelectedAndSaturday || isMonthEnd {
            MaskedRoundedRectangle(cornerRadius: CXSpacing.oneX, corners: [.topRight, .bottomRight])
                .fill(.blue.opacity(0.2))
        } else if isSelected {
            MaskedRoundedRectangle(cornerRadius: .zero)
                .fill(.blue.opacity(0.2))
        } else {
            MaskedRoundedRectangle(cornerRadius: .zero)
                .fill(.clear)
        }
    }

    private var font: Font {
        isFirstDate ? .body.bold() : .body
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

    private var isSelectedAndSunday: Bool {
        let isSunday = calendar.component(.weekday, from: day) == 1
        return isSunday && isSelected
    }

    private var isSelectedAndSaturday: Bool {
        let isSaturday = calendar.component(.weekday, from: day) == 7
        return isSaturday && isSelected
    }

    private var isMonthStart: Bool {
        guard isSelected else {
            return false
        }
        let startOfMonth = calendar.startOfMonth(for: day)
        return calendar.isSameDay(day, startOfMonth)
    }

    private var isMonthEnd: Bool {
        guard isSelected else {
            return false
        }
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
