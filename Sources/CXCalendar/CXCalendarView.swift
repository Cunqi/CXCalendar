//
//  CXCalendarView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXUICore
import CXLazyPage
import SwiftUI

public struct CXCalendarView: View, CXCalendarAccessible {

    // MARK: - Properties

    @State public var manager: CXCalendarManager

    @Binding var backToToday: Bool

    // MARK: - Initializer
    
    /// A SwiftUI view that represents a calendar view.
    /// - Parameters:
    ///   - context: The context for the calendar, which includes configuration options like axis and header view.
    ///   - backToToday: A binding that indicates whether the calendar should return to today's date when it changes. this gives
    ///   the ability to reset the calendar view to today's date externally.
    public init(context: CXCalendarContext = .paged,
                backToToday: Binding<Bool> = .constant(false)) {
        manager = CXCalendarManager(context: context)
        _backToToday = backToToday
    }

    public var body: some View {
        VStack(spacing: manager.context.rowPadding) {
            manager.context.calendarHeader(currentDate).erased

            CXLazyPage(axis: manager.context.axis, currentPage: $manager.currentPage) { index in
                MonthView(month: manager.makeMonthFromStart(offset: index))
                Spacer()
            }
        }
        .environment(manager)
        .onChange(of: selectedDate) { oldValue, newValue in
            manager.context.onSelected?(newValue)
        }
        .onChange(of: currentDate) { oldValue, newValue in
            withAnimation {
                manager.selectedDate = nil
            }
        }
        .onChange(of: currentDate) { oldValue, newValue in
            manager.context.onMonthChanged?(newValue)
        }
        .onChange(of: backToToday) { oldValue, newValue in
            manager.resetToToday()
        }
    }
}

#Preview {
    CXCalendarView()
}

