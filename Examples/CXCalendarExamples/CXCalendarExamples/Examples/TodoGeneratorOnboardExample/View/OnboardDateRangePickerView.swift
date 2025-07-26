//
//  OnboardDateRangePickerView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/21/25.
//

import CXCalendar
import SwiftUI

struct OnboardDateRangePickerView: View {
    // MARK: Internal

    let context = CXCalendarContext.month(.scroll)
        .builder
        .columnPadding(.zero)
        .calendarHeader { month in
            WeekdayOnlyHeaderView(month: month)
        }
        .dayView { dateInterval, day, _ in
            OnboardDayView(dateInterval: dateInterval, day: day)
        }
        .build()

    var body: some View {
        VStack {
            HStack {
                DateDisplayCardView(label: "From", date: viewModel.interval?.start)
                DateDisplayCardView(label: "To", date: viewModel.interval?.end)
            }
            .padding(.horizontal)
            CXCalendarView(context: context)
                .padding(.horizontal)
                .environment(viewModel)
        }
        .navigationTitle("Range")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Next") {
                    isNavigating = true
                }
                .disabled(isNextButtonDisabled)
            }
        }
        .navigationDestination(isPresented: $isNavigating) {
            OnboardTodoDisplayView(startDate: viewModel.interval?.start ?? .now)
                .environment(viewModel)
        }
        .onChange(of: viewModel.interval) { _, newValue in
            isNextButtonDisabled = newValue == nil
        }
    }

    // MARK: Private

    @State private var viewModel = TodoGeneratorOnboardViewModel()
    @State private var isNextButtonDisabled = true
    @State private var isNavigating = false
}
