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

    /// Initializes a `CXCalendar` instance with the specified template and optional
    /// binding to control returning to the start date.
    ///
    /// - Parameters:
    ///   - template: The calendar template that defines the initial configuration of the calendar.
    public init(template: CXCalendarTemplate, anchorDate: Binding<Date> = .constant(.now)) {
        _coordinator = State(initialValue: CXCalendarCoordinator(template: template))
        _anchorDate = anchorDate
    }

    // MARK: Public

    @State public var coordinator: CXCalendarCoordinator
    @Binding public var anchorDate: Date

    public var body: some View {
        Group {
            switch core.scrollStrategy {
            case .page:
                InfinityPageContainer(coordinator: $coordinator)
            case .scroll:
                ScrollCalendarContainer(coordinator: $coordinator)
            }
        }
        .onChange(of: coordinator.anchorDate) { _, newValue in
            anchorDate = newValue
        }
        .onChange(of: anchorDate) { _ in
            withAnimation {
                coordinator.scroll(to: anchorDate)
            }
        }
    }
}

#Preview {
    CXCalendarView(template: .month(.page), anchorDate: .constant(Date()))
        .padding(.horizontal)
}
