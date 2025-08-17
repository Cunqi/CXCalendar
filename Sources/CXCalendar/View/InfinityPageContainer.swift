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
    // MARK: Internal

    @Binding var coordinator: CXCalendarCoordinator

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: .zero) {
                calendarHeader(proxy: proxy)
                calendarBody(proxy: proxy)
                accessoryView
            }
        }
        .environment(coordinator)
    }

    // MARK: Private

    @ViewBuilder
    private var accessoryView: some View {
        if let accessoryView = compose.accessoryView,
           coordinator.canPresentAccessoryView {
            accessoryView(coordinator.selectedDate)
                .erased
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }

    private func calendarBody(proxy: GeometryProxy) -> some View {
        CXInfinityPage(
            axis: layout.axis,
            currentPage: $coordinator.currentPage,
            scrollEnabled: $coordinator.scrollEnabled
        ) {
            withAnimation {
                coordinator.setAllowPresentingAccessoryView(false)
            }
        } page: {
            CalendarPage(date: coordinator.date(at: $0))
        }
        .frame(
            width: proxy.size.width,
            height: coordinator.sizeProvider.calendarHeight
        )
    }

    private func calendarHeader(proxy: GeometryProxy) -> some View {
        Group {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(anchorDate).erased
            } else {
                Color.clear
                    .frame(height: .zero)
            }
        }
        .onDimensionChange {
            coordinator.sizeProvider.calculateHeightForPageStrategy(
                with: proxy,
                titleHeight: $0.size.height
            )
        }
    }
}
