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
    public init(template: CXCalendarTemplate, anchorDate: Binding<Date>? = nil) {
        _coordinator = State(initialValue: CXCalendarCoordinator(template: template))
        _anchorDate = OptionalBinding(.now, anchorDate)
    }

    // MARK: Public

    @State public var coordinator: CXCalendarCoordinator

    public var body: some View {
        Group {
            switch core.scrollStrategy {
            case .page:
                PageCalendarContainer(coordinator: $coordinator)
            case .scroll:
                ScrollCalendarContainer(coordinator: $coordinator)
            }
        }
        .onChange(of: coordinator.anchorDate) { _, newValue in
            anchorDate = newValue
        }
        .onChange(of: anchorDate) { _, _ in
            withAnimation {
                coordinator.scroll(to: anchorDate)
            }
        }
        .onChange(of: coordinator.selectedDate) { _, newValue in
            interaction.onCalendarItemSelect?(newValue)
        }
    }

    // MARK: Internal

    @OptionalBinding var anchorDate: Date
}

#Preview {
    CXCalendarView(template: .month(.page), anchorDate: .constant(Date()))
        .padding(.horizontal)
}
