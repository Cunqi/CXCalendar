//
//  ScrollCalendarContainer.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/15/25.
//

import CXLazyPage
import SwiftUI

/// This view represents a paged calendar that allows users to navigate through dates in a seamless manner.
struct ScrollCalendarContainer: CXCalendarViewRepresentable {
    @Binding var coordinator: CXCalendarCoordinator

    var body: some View {
        VStack(spacing: layout.vPadding) {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(currentAnchorDate).erased
            }

            GeometryReader { proxy in
                CXLazyList(
                    currentPage: $coordinator.currentPage,
                    content: { index in
                        CalendarPage(date: coordinator.date(at: index))
                    }, heightOfPage: { index in
                        coordinator.sizeProvider.calculatePageHeight(
                            at: index,
                            numOfRows: coordinator.numOfRows(at: index)
                        )
                    }
                )
                .frame(
                    width: proxy.size.width,
                    height: coordinator.sizeProvider.calendarHeight
                )
                .onAppear {
                    coordinator.sizeProvider.calculateHeightForScrollStrategy(with: proxy.size)
                }
                .onChange(of: coordinator.currentAnchorDate) { _, newValue in
                    interaction.onAnchorDateChange?(newValue)
                }
            }
        }
        .environment(coordinator)
    }
}
