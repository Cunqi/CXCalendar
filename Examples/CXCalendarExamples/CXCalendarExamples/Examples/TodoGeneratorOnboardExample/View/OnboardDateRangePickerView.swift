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
        .dayView({ dateInterval, day, _ in
            OnboardDayView(dateInterval: dateInterval, day: day)
        })
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
                    // Handle navigation to the next view
                }
            }
        }
    }

    // MARK: Private

    @State private var viewModel = TodoGeneratorOnboardViewModel()
}
