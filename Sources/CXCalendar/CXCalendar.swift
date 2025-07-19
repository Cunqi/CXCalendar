//
//  CXCalendar.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/19/25.
//

import CXLazyPage
import SwiftUI

public struct CXCalendar: View, CXContextAccessible {
    // MARK: Lifecycle

    public init(context: CXCalendarContext, backToToday: Binding<Bool> = .constant(false)) {
        manager = CXCalendarManager(context: context)
        _backToToday = backToToday
    }

    // MARK: Public

    @State public var manager: CXCalendarManager

    public var body: some View {
        switch calendarType {
        case .month(let scrollBehavior):
            monthView(for: scrollBehavior)
                .environment(manager)
        case .week:
            PagedCalendar(context: context, backToToday: $backToToday)
                .environment(manager)
        }
    }

    // MARK: Internal

    @ViewBuilder
    func monthView(for scrollBehavior: CXCalendarScrollBehavior) -> some View {
        switch scrollBehavior {
        case .page:
            PagedCalendar(context: context, backToToday: $backToToday)
        case .scroll:
            ScrollableCalendar(context: context, backToToday: $backToToday)
        }
    }

    // MARK: Private

    @Binding private var backToToday: Bool
}
