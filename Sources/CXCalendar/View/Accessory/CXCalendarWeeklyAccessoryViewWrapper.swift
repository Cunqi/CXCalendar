//
//  CXCalendarWeeklyAccessoryViewWrapper.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXFoundation
import SwiftUI

/// The `CXCalendarWeeklyAccessoryViewWrapper` is a SwiftUI view that wraps a calendar accessory
/// It provides the ability to scroll through a week's worth of dates, displaying the accessory content for each date.
public struct CXCalendarWeeklyAccessoryViewWrapper<AccessoryView: CXCalendarViewRepresentable>:
    CXCalendarViewRepresentable {
    // MARK: Lifecycle

    /// Creates a new instance of `CXCalendarWeeklyAccessoryViewWrapper`.
    /// - Parameters:
    ///   - date: The date that the accessory date relates to.
    ///   - interval: The interval that the accessory interval relates to.
    ///   - content: A closure that returns the accessory content view for a given date and the calendar manager.
    public init(
        date: Date,
        interval: DateInterval,
        @ViewBuilder content: @escaping ComposeCalendarAccessoryView
    ) {
        focusedDate = date
        self.date = date
        self.interval = interval
        self.content = content
    }

    // MARK: Public

    @Environment(CXCalendarCoordinator.self) public var coordinator

    public var body: some View {
        TabView(selection: $focusedDate) {
            ForEach(items) { item in
                content(item.value).erased
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: focusedDate) { _, newValue in
            withAnimation {
                coordinator.selectedDate = newValue
            }
        }
        .onChange(of: coordinator.selectedDate) { _, newValue in
            if !calendar.isSameDay(newValue, focusedDate) {
                // If the weekly accessory view is not currently forcused on the selected date,
                // this means the user is scrolling the calendar view.
                // In all of following conditions were met, we should disable the animation.
                // 1. The focused date is not in the current week interval.
                // 2. user is scrolling backward and selected date is smaller than the focused date.

                let isInRange = interval.containsExceptEnd(focusedDate, calendar)
                let isMovingBackward = calendar.compare(
                    newValue,
                    to: focusedDate,
                    toGranularity: .day
                ) == .orderedAscending
                let shouldDisableAnimation = !isInRange && isMovingBackward
                withAnimation(shouldDisableAnimation ? nil : .default) {
                    focusedDate = newValue
                }
            }
        }
    }

    // MARK: Internal

    let date: Date
    let interval: DateInterval
    let content: ComposeCalendarAccessoryView

    // MARK: Private

    @State private var focusedDate: Date

    private var items: [CXIndexedDate] {
        coordinator.items(for: interval, .week, .page)
    }
}
