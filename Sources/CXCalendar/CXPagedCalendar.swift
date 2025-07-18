//
//  CXPagedCalendar.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXLazyPage
import CXUICore
import SwiftUI

public struct CXPagedCalendar: View, CXCalendarAccessible, CXContextAccessible {

    // MARK: Lifecycle

    // MARK: - Initializer

    /// A SwiftUI view that represents a calendar view.
    /// - Parameters:
    ///   - context: The context for the calendar, which includes configuration options like axis and header view.
    ///   - backToToday: A binding that indicates whether the calendar should return to today's date when it changes.
    /// This gives the ability to reset the calendar view to today's date externally.
    public init(
        context: CXCalendarContext = .paged,
        backToToday: Binding<Bool> = .constant(false)
    ) {
        if context.style != .paged {
            assertionFailure("CXPagedCalendar only supports paged style.")
        }

        manager = CXCalendarManager(context: context)
        _backToToday = backToToday
    }

    // MARK: Public

    @State public var manager: CXCalendarManager

    public var body: some View {
        VStack(spacing: layout.rowPadding) {
            compose.calendarHeader(currentDate).erased

            CXLazyPage(axis: layout.axis, currentPage: $manager.currentPage) { index in
                MonthView(month: manager.makeMonthFromStart(offset: index))
                Spacer()
            }
        }
        .environment(manager)
        .onChange(of: selectedDate) { _, newValue in
            interaction.onSelected?(newValue)
        }
        .onChange(of: currentDate) { _, _ in
            withAnimation {
                manager.selectedDate = nil
            }
        }
        .onChange(of: currentDate) { _, newValue in
            interaction.onMonthChanged?(newValue)
        }
        .onChange(of: backToToday) { _, _ in
            manager.resetToToday()
        }
    }

    // MARK: Internal

    @Binding var backToToday: Bool

}

#Preview {
    CXPagedCalendar()
}
