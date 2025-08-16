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
        VStack(spacing: .zero) {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(anchorDate).erased
            }

            GeometryReader { proxy in
                let _ = coordinator.sizeProvider.calculateHeightForPageStrategy(with: proxy)
                CXLazyPage(
                    axis: layout.axis,
                    currentPage: $coordinator.currentPage
                ) { index in
                    CalendarPage(date: coordinator.date(at: index))
                }
                .onChange(of: coordinator.currentPage) { _, _ in
                    coordinator.setAllowPresentingAccessoryView(false)
                }
            }
        }
        .environment(coordinator)
    }
}
