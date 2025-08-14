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
        VStack {
            if let calendarHeader = compose.calendarHeader {
                calendarHeader(currentAnchorDate)
                    .erased
            }

            CXLazyList(currentPage: $coordinator.currentPage) { _ in
                // compose.body(manager.makeDate(for: index))
                //     .erased
            } heightOf: { index in
                0
            }
        }
        .environment(coordinator)
    }
}
