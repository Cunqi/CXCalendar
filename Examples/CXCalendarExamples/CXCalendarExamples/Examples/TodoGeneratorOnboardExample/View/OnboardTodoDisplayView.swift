//
//  OnboardTodoDisplayView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/22/25.
//

import CXCalendar
import CXUICore
import SwiftUI

// MARK: - OnboardTodoDisplayView

struct OnboardTodoDisplayView: View {
    // MARK: Lifecycle

    init(startDate: Date) {
        self.startDate = startDate
        let shouldSelect = Calendar.current.isSameMonthInYear(.now, startDate)
        context = CXCalendarContext.month(.page)
            .builder
            .startDate(startDate)
            .selectedDate(shouldSelect ? .now : startDate)
            .dayView { dateInterval, day, _ in
                OnboardTodoDayView(dateInterval: dateInterval, day: day)
            }
            .accessoryView { date in
                OnboardDailyTodoAccessoryView(date: date, showDetailButton: true)
            }
            .build()
    }

    // MARK: Internal

    @Environment(TodoGeneratorOnboardViewModel.self) var viewModel

    let startDate: Date
    let context: CXCalendarContext


    var body: some View {
        CXCalendarView(context: context)
            .onAppear {
                viewModel.generateTodo()
            }
            .navigationDestination(item: $detailDate, destination: { date in
                OnboardTodoDetailDisplayView(startDate: date)
                    .environment(viewModel)
            })
            .onChange(of: viewModel.detailDate) { oldValue, newValue in
                if newValue != nil {
                    detailDate = newValue
                }
            }
            .onChange(of: detailDate) { oldValue, newValue in
                if detailDate == nil {
                    viewModel.detailDate = nil
                }
            }
    }

    // MARK: Private

    @State private var detailDate: Date?
}

// MARK: - OnboardTodoDayView

struct OnboardTodoDayView: CXCalendarDayViewRepresentable {
    // MARK: Internal

    @Environment(TodoGeneratorOnboardViewModel.self) var viewModel
    @Environment(CXCalendarManager.self) var manager

    var dateInterval: DateInterval

    var day: Date

    var isSelected: Bool {
        calendar.isSameDay(day, selectedDate)
    }

    var body: some View {
        Text(day, format: .dateTime.day())
            .overlay(alignment: .bottom) {
                if viewModel.isInTodoList(day, calendar: Calendar.current) {
                    todoIndicator
                        .padding(.bottom, -CXSpacing.oneX)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background {
                background
            }
            .overlay {
                if isSelected {
                    Circle()
                        .stroke(.primary, lineWidth: CXSpacing.quarterX)
                        .padding(1)
                }
            }
            .onTapGesture {
                withAnimation {
                    if calendar.isSameDay(day, selectedDate) {
                        manager.togglePresentAccessoryView()
                    } else {
                        manager.enablePresentAccessoryView(true)
                    }
                    manager.selectedDate = day
                }
            }
    }

    // MARK: Private

    private var background: some View {
        if isInRange {
            Circle()
                .fill(.green.opacity(0.1))
        } else {
            Circle()
                .fill(.clear)
        }
    }

    private var todoIndicator: some View {
        Circle()
            .fill(.red)
            .frame(width: CXSpacing.halfX, height: CXSpacing.halfX)
    }
}
