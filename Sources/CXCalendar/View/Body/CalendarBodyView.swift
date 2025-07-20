//
//  CalendarBodyView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI

// MARK: - CalendarBodyView

struct CalendarBodyView: CXCalendarViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let date: Date

    // MARK: - Initializer

    var body: some View {
        VStack(spacing: layout.rowPadding) {
            if let bodyHeader = compose.bodyHeader {
                bodyHeader(date)
                    .frame(height: layout.rowHeight)
                    .frame(maxWidth: .infinity)
                    .erased
            }

            compose.bodyContent(date).erased

            if let accessoryView = compose.accessoryView, case .month = calendarType {
                accessoryView(selectedDate)
                    .erased
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
