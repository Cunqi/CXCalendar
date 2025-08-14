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
        let context = CXCalendarCoordinator.month(.page)
            .builder
            .columnPadding(.zero)
            .dayView { dateInterval, day, _ in
                RangeDay(dateInterval: dateInterval, date: day, range: $viewModel.range)
            }
            .onSelected { date in
                guard let date else {
                    return
                }
                viewModel.pick(date: date)
            }
            .build()

        VStack {
            CXCalendarView(context: context)
                .navigationTitle("Calendar with Range Pick")
                .navigationBarTitleDisplayMode(.inline)

            HStack {
                DateDisplayCardView(label: "From", date: viewModel.range?.start)

                DateDisplayCardView(label: "To", date: viewModel.range?.end)
            }
            .padding(.horizontal)

            Spacer()
        }
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

struct RangeDay: CXCalendarDayViewRepresentable {
    @Environment(CXCalendarCoordinator.self) var manager

    let dateInterval: DateInterval
    let date: CXIndexedDate
    @Binding var range: DateInterval?

    let isInRange = true

    var isStartDate: Bool {
        calendar.isDate(date.value, inSameDayAs: startDate)
    }

    var isSelected: Bool {
        guard let range else {
            return false
        }
        return range.contains(date.value)
    }

    var isLeadingDay: Bool {
        guard let range else {
            return false
        }
        return calendar.isDate(date.value, inSameDayAs: range.start)
    }

    var isTrailingDay: Bool {
        guard let range else {
            return false
        }
        return calendar.isDate(date.value, inSameDayAs: range.end)
    }

    var body: some View {
        Text(day.day)
            .font(isStartDate ? .body.bold() : .body)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background {
                background
            }
            .onTapGesture {
                withAnimation {
                    interaction.onSelected?(date.value)
                }
            }
    }

    var background: some View {
        if isLeadingDay, isTrailingDay {
            MaskedRoundedRectangle(cornerRadius: CXSpacing.oneX)
                .fill(Color.accentColor.opacity(0.5))
        } else if isLeadingDay {
            MaskedRoundedRectangle(cornerRadius: CXSpacing.oneX, corners: [.topLeft, .bottomLeft])
                .fill(Color.accentColor.opacity(0.5))
        } else if isTrailingDay {
            MaskedRoundedRectangle(cornerRadius: CXSpacing.oneX, corners: [.topRight, .bottomRight])
                .fill(Color.accentColor.opacity(0.5))
        } else if isSelected {
            MaskedRoundedRectangle(cornerRadius: .zero)
                .fill(Color.accentColor.opacity(0.5))
        } else {
            MaskedRoundedRectangle(cornerRadius: .zero)
                .fill(Color.clear)
        }
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
