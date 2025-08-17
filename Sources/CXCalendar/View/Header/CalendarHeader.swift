//
//  CalendarHeader.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import CXUICore
import SwiftUI

/// The `CalendarHeader` is a SwiftUI view that displays the header of a calendar,
/// including the month and year,
struct CalendarHeader: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarCoordinator.self) var coordinator

    let date: Date

    var body: some View {
        VStack {
            headerTextBar

            if core.mode != .year {
                CXWeekOnlyCalendarHeader()
            }
            Divider()
                .padding(.bottom, CXSpacing.oneX)
        }
    }

    // MARK: Private

    private var headerTextBar: some View {
        HStack(alignment: .firstTextBaseline, spacing: CXSpacing.halfX) {
            switch core.mode {
            case .month, .week:
                monthlyTitleHeader
            case .year:
                yearlyTitleHeader
            }

            Spacer()

            resetButton
        }
    }

    @ViewBuilder
    private var monthlyTitleHeader: some View {
        Text(date, format: .dateTime.month())
            .font(.title)
            .bold()
            .foregroundColor(.primary)

        Text(date, format: .dateTime.year())
            .font(.subheadline)
            .foregroundColor(.secondary)
    }

    private var yearlyTitleHeader: some View {
        Text(date, format: .dateTime.year())
            .font(.title)
            .bold()
            .foregroundColor(.primary)
    }

    @ViewBuilder
    private var resetButton: some View {
        if coordinator.isCalendarChanged {
            Button {
                withAnimation(.interactiveSpring) {
                    coordinator.reset()
                }
            } label: {
                makeResetButtonImage()
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        }
    }

    @ViewBuilder
    private func makeResetButtonImage() -> some View {
        let isPageScroll = core.scrollStrategy == .page
        let compareResult = calendar.compare(date, to: startDate, toGranularity: .day)
        switch compareResult {
        case .orderedAscending, .orderedDescending:
            resetButtonImage(for: compareResult, isPageScroll: isPageScroll)
        case .orderedSame:
            let inMonthCompareResult = calendar.compare(
                coordinator.selectedDate,
                to: startDate,
                toGranularity: .day
            )
            resetButtonImage(for: inMonthCompareResult, isPageScroll: isPageScroll)
        }
    }

    @ViewBuilder
    private func resetButtonImage(
        for compareResult: ComparisonResult,
        isPageScroll: Bool
    ) -> some View {
        switch compareResult {
        case .orderedSame:
            EmptyView()
        case .orderedAscending:
            Image(systemName: isPageScroll ? "arrow.right.to.line" : "arrow.down.to.line")

        case .orderedDescending:
            Image(systemName: isPageScroll ? "arrow.left.to.line" : "arrow.up.to.line")
        }
    }
}
