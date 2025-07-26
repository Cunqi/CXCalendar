//
//  CalendarBodyView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI

// MARK: - CalendarBodyView

/// This view represents the monthly body of the calendar,
/// displaying the header, body content, and any accessory views.
struct CalendarMonthlyBodyView: CXCalendarBodyViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let date: Date

    // MARK: - Initializer

    var body: some View {
        VStack(spacing: layout.rowPadding) {
            if let bodyHeader = compose.bodyHeader {
                bodyHeader(date)
                    .frame(height: layout.bodyHeaderHeight)
                    .frame(maxWidth: .infinity)
                    .erased
            }

            CalendarBodyContentView(date: date)

            if let accessoryView = compose.accessoryView,
               manager.shouldPresentAccessoryView(for: date) {
                accessoryView(selectedDate)
                    .erased
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
