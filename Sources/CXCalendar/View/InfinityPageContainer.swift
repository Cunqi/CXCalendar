//
//  InfinityPageContainer.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/14/25.
//

import CXLazyPage
import CXUICore
import SwiftUI

// MARK: - InfinityPageContainer

/// This view represents an infinite paged calendar that allows users to navigate through dates in a paginated manner.
struct InfinityPageContainer: CXCalendarViewRepresentable {
    @Binding var coordinator: CXCalendarCoordinator

    var body: some View {
        let _ = Self._printChanges()
        VStack(spacing: layout.vPadding) {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(anchorDate).erased
            }

            GeometryReader { proxy in
                CXInfinityPage(
                    axis: layout.axis,
                    currentPage: $coordinator.currentPage,
                    scrollEnabled: $coordinator.scrollEnabled
                ) { index in
                    CalendarPage(date: coordinator.date(at: index))
                }
                .frame(
                    width: proxy.size.width,
                    height: coordinator.sizeProvider.calendarHeight
                )
                .onAppear {
                    coordinator.sizeProvider
                        .calculateHeightForPageStrategy(with: proxy.size)
                }
            }
        }
        .environment(coordinator)
    }
}
