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
    public init(context: CXCalendarContext) {
        _coordinator = State(initialValue: CXCalendarCoordinator(context: context))
    }

    // MARK: Public

    @State public var coordinator: CXCalendarCoordinator

    public var body: some View {
        switch core.scrollStrategy {
        case .page:
            PagedCalendarContainer(coordinator: $coordinator)
        case .scroll:
            PagedCalendarContainer(coordinator: $coordinator)
        }
    }
}

#Preview {
    CXCalendarView(context: .month(.page))
        .padding(.horizontal)
}
