//
//  CXScrollableCalendar.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/15/25.
//

import CXLazyPage
import SwiftUI

public struct CXScrollableCalendar: View, CXCalendarAccessible {
    @State public var manager: CXCalendarManager

    @Binding var backToToday: Bool
    
    /// A scrollable calendar view that displays months in a paginated format.
    /// - Parameters:
    ///   - context: The context for the calendar, which includes configuration options like axis and header view.
    ///   - backToToday: A binding that indicates whether the calendar should return to today's date when it changes. This gives
    ///   the ability to reset the calendar view to today's date externally.
    public init(context: CXCalendarContext = .paged,
                backToToday: Binding<Bool> = .constant(false)) {
        manager = CXCalendarManager(context: context)
        _backToToday = backToToday
    }

    public var body: some View {
        VStack {
            manager.context.calendarHeader(currentDate).erased
            CXLazyList { index in
                MonthView(month: manager.makeMonthFromStart(offset: index))
            } heightOf: { index in
                let rowHeight = Int(manager.context.rowHeight)
                let rowPadding = Int(manager.context.rowPadding)
                let numberOfWeeks = manager.numberOfWeeks(for: index) + 1 // month header
                return numberOfWeeks * (rowHeight + rowPadding) - rowPadding
            }
        }
        .environment(manager)
    }
}
