//
//  CXCalendarWeeklyAccessoryWrapperView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXFoundation
import SwiftUI

/// The `CXCalendarWeeklyAccessoryWrapperView` is a SwiftUI view that wraps a calendar accessory
/// It provides the ability to scroll through a week's worth of dates, displaying the accessory content for each date.
public struct CXCalendarWeeklyAccessoryWrapperView<AccessoryContent: View>:
    CXCalendarViewRepresentable {
    // MARK: Lifecycle
    
    /// Creates a new instance of `CXCalendarWeeklyAccessoryWrapperView`.
    /// - Parameters:
    ///   - date: The date that the accessory date relates to.
    ///   - content: A closure that returns the accessory content view for a given date and the calendar manager.
    public init(
        date: Date,
        @ViewBuilder content: @escaping (Date, CXCalendarManager) -> AccessoryContent
    ) {
        focusedDate = date
        self.date = date
        self.content = content
    }

    // MARK: Public

    @Environment(CXCalendarManager.self) public var manager

    public var body: some View {
        TabView(selection: $focusedDate) {
            ForEach(days) { day in
                content(day.value, manager)
                    .tag(day.value)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: focusedDate) { _, newValue in
            withAnimation {
                manager.selectedDate = newValue
            }
        }
        .onChange(of: manager.selectedDate) { _, newValue in
            if !calendar.isSameDay(newValue, focusedDate) {
                withAnimation {
                    focusedDate = newValue
                }
            }
        }
    }

    // MARK: Internal

    let date: Date
    let content: (Date, CXCalendarManager) -> AccessoryContent

    // MARK: Private

    @State private var focusedDate: Date

    private var days: [IdentifiableDate] {
        manager.makeDays(from: manager.makeDateInterval(for: date))
    }
}
