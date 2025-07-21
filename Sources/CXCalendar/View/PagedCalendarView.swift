//
//  PagedCalendarView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXLazyPage
import CXUICore
import SwiftUI

/// This view represents a paged calendar that allows users to navigate through dates in a paginated manner.
struct PagedCalendarView: CXCalendarViewRepresentable {
    // MARK: Lifecycle

    // MARK: - Initializer

    init(context: CXCalendarContext, backToStart: Binding<Bool>) {
        manager = CXCalendarManager(context: context)
        _backToStart = backToStart
    }

    // MARK: Internal

    @State var manager: CXCalendarManager
    @Binding var backToStart: Bool

    var body: some View {
        VStack(spacing: layout.rowPadding) {
            compose.calendarHeader(currentAnchorDate)
                .erased
                .padding(.horizontal, layout.calendarHPadding)

            CXLazyPage(axis: layout.axis, currentPage: $manager.currentPage) { index in
                CalendarBodyView(date: manager.makeDate(for: index))
                    .padding(.horizontal, layout.calendarHPadding)
            }
        }
        .environment(manager)
        .onChange(of: selectedDate) { _, newValue in
            interaction.onSelected?(newValue)
        }
        .onChange(of: currentAnchorDate) { _, newValue in
            interaction.onMonthChanged?(newValue)
        }
        .onChange(of: backToStart) { _, _ in
            manager.backToStart()
        }
    }
}
