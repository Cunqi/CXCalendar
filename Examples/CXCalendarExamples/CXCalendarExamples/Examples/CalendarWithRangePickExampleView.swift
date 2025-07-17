//
//  CalendarWithRangePickExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXUICore
import SwiftUI
import Observation

struct CalendarWithRangePickExampleView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        let context = CXCalendarContext.paged.builder
            .columnPadding(.zero)
            .dayView { month, day in
                RangeDay(month: month, day: day, range: $viewModel.range)
            }
            .onSelected({ date in
                guard let date else {
                    return
                }
                viewModel.pick(date: date)
            })
            .build()

        VStack {
            CXPagedCalendar(context: context)
                .navigationTitle("Calendar with Range Pick")
                .navigationBarTitleDisplayMode(.inline)

            HStack {
                fromDateCard

                toDateCard
            }

            Spacer()
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    func makeTimeCard(for date: Date, title: String) -> some View {
        VStack(alignment: .leading, spacing: CXSpacing.halfX) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(date, format: .dateTime.day().month(.abbreviated).year())
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

    @ViewBuilder
    var fromDateCard: some View {
        if let start = viewModel.range?.start {
            makeTimeCard(for: start, title: "From")
        } else {
            makePlaceholderCard(title: "From")
        }
    }

    @ViewBuilder
    var toDateCard: some View {
        if let end = viewModel.range?.end {
            makeTimeCard(for: end, title: "To")
        } else {
            makePlaceholderCard(title: "To")
        }
    }
}

struct RangeDay: CXDayViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date
    let day: Date
    @Binding var range: DateInterval?

    let isInCurrentMonth: Bool = true

    var isToday: Bool {
        calendar.isDateInToday(day)
    }

    var isSelected: Bool {
        guard let range else { return false }
        return range.contains(day)
    }

    var isLeadingDay: Bool {
        guard let range else { return false }
        return calendar.isDate(day, inSameDayAs: range.start)
    }

    var isTrailingDay: Bool {
        guard let range else { return false }
        return calendar.isDate(day, inSameDayAs: range.end)
    }

    var body: some View {
        Text(day.day)
            .font(isToday ? .body.bold() : .body)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background {
                background
            }
            .onTapGesture {
                withAnimation {
                    interaction.onSelected?(day)
                }
            }
    }

    var background: some View {
        if isLeadingDay && isTrailingDay {
            MaskedRoundedRectangle(radius: CXSpacing.oneX)
                .fill(Color.accentColor.opacity(0.5))
        } else if isLeadingDay {
            MaskedRoundedRectangle(radius: CXSpacing.oneX, corners: [.topLeft, .bottomLeft])
                .fill(Color.accentColor.opacity(0.5))
        } else if isTrailingDay {
            MaskedRoundedRectangle(radius: CXSpacing.oneX, corners: [.topRight, .bottomRight])
                .fill(Color.accentColor.opacity(0.5))
        } else if isSelected {
            MaskedRoundedRectangle(radius: .zero)
                .fill(Color.accentColor.opacity(0.5))
        } else {
            MaskedRoundedRectangle(radius: .zero)
                .fill(Color.clear)
        }
    }
}

struct MaskedRoundedRectangle: Shape {
    var radius: CGFloat = CXSpacing.oneX
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

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
