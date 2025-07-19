//
//  ScrollableCalendar.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/15/25.
//

import CXLazyPage
import SwiftUI

public struct ScrollableCalendar: View, CXCalendarAccessible, CXContextAccessible {
    // MARK: Lifecycle

    /// A scrollable calendar view that displays months in a paginated format.
    /// - Parameters:
    ///   - context: The context for the calendar, which includes configuration options like axis and header view.
    ///   - backToToday: A binding that indicates whether the calendar should return to today's date when it changes.
    /// This gives the ability to reset the calendar view to today's date externally.
    public init(context: CXCalendarContext, backToToday: Binding<Bool>) {
        manager = CXCalendarManager(context: context)
        _backToToday = backToToday
    }

    // MARK: Public

    @State public var manager: CXCalendarManager

    public var body: some View {
        VStack {
            compose.calendarHeader(currentDate)
                .erased
                .padding(.horizontal, layout.calendarHPadding)
            CXLazyList(
                viewportTrackerContext: viewportContext,
                currentPage: $manager.currentPage
            ) { index in
                CalendarBodyView(date: manager.makeDate(for: index))
                    .padding(.horizontal, layout.calendarHPadding)
            } heightOf: { index in
                let rowHeight = Int(layout.rowHeight)
                let rowPadding = Int(layout.rowPadding)
                let numberOfRows = manager.numberOfRows(for: index)
                return numberOfRows * (rowHeight + rowPadding) - rowPadding
            }
        }
        .environment(manager)
        .onChange(of: backToToday) { _, _ in
            manager.resetToToday()
        }
        .onChange(of: currentDate) { _, newValue in
            interaction.onMonthChanged?(newValue)
        }
    }

    // MARK: Internal

    @Binding var backToToday: Bool

    // MARK: Private

    private let viewportContext: ViewportTrackerContext = {
        var showViewportTracker = false
        #if DEBUG
        showViewportTracker = true
        #endif

        return ViewportTrackerContext.default
            .builder
            .showDetectArea(showViewportTracker)
            .build()
    }()
}
