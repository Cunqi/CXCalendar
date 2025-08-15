//
//  LazyPageContainer.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/14/25.
//

import CXLazyPage
import CXUICore
import SwiftUI

struct LazyPageContainer: CXCalendarViewRepresentable {
    @Binding var coordinator: CXCalendarCoordinator

    var body: some View {
        VStack(spacing: layout.vPadding) {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(anchorDate).erased
            }

            GeometryReader { proxy in
                CXLazyPage(
                    axis: layout.axis,
                    currentPage: $coordinator.currentPage,
                    content: { index in
                        CalendarPage(date: coordinator.date(at: index))
                    }
                )
                .frame(
                    width: proxy.size.width,
                    height: coordinator.sizeProvider.calendarHeight
                )
                .onAppear {
                    coordinator.sizeProvider
                        .calculateHeightForPageStrategy(with: proxy.size)
                }
                .onChange(of: coordinator.currentPage) { _, _ in
                    coordinator.enablePresentAccessoryView(false)
                }
            }
        }
        .environment(coordinator)
    }
}
