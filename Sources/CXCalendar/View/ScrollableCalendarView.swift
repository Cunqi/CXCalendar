//
//  ScrollableCalendarView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/15/25.
//

import CXLazyPage
import SwiftUI

/// This view represents a paged calendar that allows users to navigate through dates in a seamless manner.
struct ScrollableCalendarView: CXCalendarViewRepresentable {
    // MARK: Lifecycle

    init(context: CXCalendarContext, backToStart: Binding<Bool>) {
        manager = CXCalendarManager(context: context)
        _backToStart = backToStart
    }

    // MARK: Internal

    @State var manager: CXCalendarManager
    @Binding var backToStart: Bool

    var body: some View {
        VStack {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(currentAnchorDate)
                    .erased
                    .padding(.horizontal, layout.calendarHPadding)
            }

            CXLazyList(currentPage: $manager.currentPage) { index in
                compose.body(manager.makeDate(for: index))
                    .erased
                    .padding(.horizontal, layout.calendarHPadding)
            } heightOf: { index in
                manager.makeHeight(for: index)
            }
        }
        .environment(manager)
        .onChange(of: backToStart) { _, _ in
            manager.backToStart()
        }
        .onChange(of: currentAnchorDate) { _, newValue in
            interaction.onMonthChanged?(newValue)
        }
    }
}
