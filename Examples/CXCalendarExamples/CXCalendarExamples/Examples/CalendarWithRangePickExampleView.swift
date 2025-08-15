//
//  CalendarWithRangePickExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXUICore
import Observation
import SwiftUI

// MARK: - CalendarWithRangePickExampleView

struct CalendarWithRangePickExampleView: View {
    // MARK: Internal

    var body: some View {
        let template = CXCalendarTemplate.month(.page)
            .builder
            .calendarItem { dateInterval, day in
                RangeDay(dateInterval: dateInterval, date: day)
            }
            .build()

        VStack {
            CXCalendarView(template: template)
                .environment(viewModel)
            HStack {
                DateDisplayCardView(label: "From", date: viewModel.range?.start)

                DateDisplayCardView(label: "To", date: viewModel.range?.end)
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Calendar with Range Pick")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    func makePlaceholderCard(title: String) -> some View {
        VStack(alignment: .leading, spacing: CXSpacing.halfX) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(String.placeholder)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: CXSpacing.oneX)
                .fill(Color.accentColor.opacity(0.2))
        }
    }

    // MARK: Private

    @State private var viewModel = ViewModel()
}

// MARK: - RangeDay

struct RangeDay: CXCalendarItemViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarCoordinator.self) var coordinator
    @Environment(CalendarWithRangePickExampleView.ViewModel.self) var viewModel

    let dateInterval: DateInterval
    let date: CXIndexedDate

    var range: DateInterval? {
        viewModel.range
    }

    var isStartDate: Bool {
        calendar.isDate(date.value, inSameDayAs: startDate)
    }

    var isSelected: Bool {
        guard let range else {
            return false
        }
        return range.contains(date.value)
    }

    var body: some View {
        Text(date.value, format: .dateTime.day())
            .font(isStartDate ? .body.bold() : .body)
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background {
                background
            }
            .onTapGesture {
                viewModel.pick(date: date.value)
            }
    }

    // MARK: Private

    private var foregroundColor: Color {
        isInRange ? .primary : .secondary
    }

    private var background: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .fill(isSelected ? Color.accentColor.opacity(0.5) : .clear)
    }
}

// MARK: - CalendarWithRangePickExampleView.ViewModel

extension CalendarWithRangePickExampleView {
    @Observable
    class ViewModel {
        var range: DateInterval?

        var isPickingFirst = true

        func pick(date: Date) {
            defer {
                isPickingFirst.toggle()
            }

            if isPickingFirst {
                range = DateInterval(start: date, end: date)
            } else if let range {
                let start = min(range.start, date)
                let end = max(range.end, date)
                self.range = DateInterval(start: start, end: end)
            }
        }
    }
}
