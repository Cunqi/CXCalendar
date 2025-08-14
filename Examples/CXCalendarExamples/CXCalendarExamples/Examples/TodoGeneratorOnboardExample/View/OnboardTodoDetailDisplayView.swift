//
//  OnboardTodoDetailDisplayView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/24/25.
//

import CXCalendar
import CXUICore
import SwiftUI

struct OnboardTodoDetailDisplayView: View {
    // MARK: Lifecycle

    init(startDate: Date) {
        let shouldSelect = Calendar.current.isSameMonthInYear(.now, startDate)
        context = CXCalendarCoordinator.week()
            .builder
            .startDate(startDate)
            .selectedDate(shouldSelect ? .now : startDate)
            .dayView { dateInterval, day, _ in
                OnboardTodoDayView(dateInterval: dateInterval, date: day)
            }
            .accessoryView { date in
                CXCalendarWeeklyAccessoryWrapperView(date: date) { date, _ in
                    OnboardDailyTodoAccessoryView(date: date, showDetailButton: false)
                }
            }
            .build()
    }

    // MARK: Internal

    @Environment(TodoGeneratorOnboardViewModel.self) var viewModel

    let context: CXCalendarCoordinator

    var body: some View {
        CXCalendarView(context: context)
    }
}
