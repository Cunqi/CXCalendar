//
//  CXCalendarView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/19/25.
//

import CXLazyPage
import SwiftUI

/// The `CXCalendar` struct is a SwiftUI view that represents a calendar component.
/// It supports both month and week views, with customizable scrolling behavior.
public struct CXCalendarView: CXCalendarViewRepresentable {
    // MARK: Lifecycle

    /// Initializes a `CXCalendar` instance with the specified context and optional
    /// binding to control returning to the start date.
    ///
    /// - Parameters:
    ///   - context: The context for the calendar, which includes configuration options like axis and header view.
    ///   - backToStart: A binding that indicates whether the calendar should return to the start date when it changes.
    /// This gives the ability to reset the calendar view to the start date externally.
    public init(context: CXCalendarContext, backToStart: Binding<Bool> = .constant(false)) {
        manager = CXCalendarManager(context: context)
        _backToStart = backToStart
    }

    // MARK: Public

    @State public var manager: CXCalendarManager

    public var body: some View {
        switch context.calendarType {
        case .year(let scrollBehavior):
            calendarView(for: scrollBehavior)
                .environment(manager)
        case .month(let scrollBehavior):
            calendarView(for: scrollBehavior)
                .environment(manager)

        case .week:
            PagedCalendarView(context: context, backToStart: $backToStart)
                .environment(manager)
        }
    }

    // MARK: Internal

    @ViewBuilder
    func calendarView(for scrollBehavior: CXCalendarScrollBehavior) -> some View {
        switch scrollBehavior {
        case .page:
            PagedCalendarView(context: context, backToStart: $backToStart)
        case .scroll:
            ScrollableCalendarView(context: context, backToStart: $backToStart)
        }
    }

    // MARK: Private

    @Binding private var backToStart: Bool
}
