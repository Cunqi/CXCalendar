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
        VStack(spacing: layout.vPadding) {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(currentAnchorDate).erased
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
                    height: coordinator.sizeCoordinator.calendarHeight
                )
                .onAppear {
                    coordinator.sizeCoordinator
                        .calculateHeightForPageStrategy(with: proxy.size)
                }
                .onChange(of: coordinator.currentAnchorDate) { _, newValue in
                    interaction.onAnchorDateChange?(newValue)
                }
            }
        }
        .environment(coordinator)
    }
}
