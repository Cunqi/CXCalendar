//
//  ContentView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import SwiftUI

enum Examples: String, CaseIterable {
    case horizontal = "Horizontal"
    case vertical = "Vertical"
    case calendarWithCustomHeader = "Calendar with Custom Header"
    case calendarWithExternalMonthHeader = "Calendar with External Month Header"
    case calendarWithCustomDay = "Calendar with Custom Day"
    case calendarWithCustomSelectLogic = "Calendar with Custom Select Logic"
    case calendarWithRangePicker = "Calendar with Range Picker"
    case calendarWithAccessoryView = "Calendar with Accessory View"
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(Examples.allCases, id: \.self) { example in
                NavigationLink(destination: destination(for: example)) {
                    Text(example.rawValue.capitalized)
                }
            }
            .navigationTitle("CXCalendar Examples")
        }
    }

    @ViewBuilder
    private func destination(for example: Examples) -> some View {
        switch example {
        case .horizontal:
            HorizontalCalendarExampleView()
        case .vertical:
            VerticalCalendarExampleView()
        case .calendarWithCustomHeader:
            CalendarWithCustomHeaderExampleView()
        case .calendarWithExternalMonthHeader:
            CalendarWithExternalMonthHeaderViewExampleView()
        case .calendarWithCustomDay:
            CalendarWithCustomDayExampleView()
        case .calendarWithCustomSelectLogic:
            CalendarWithCustomSelectLogicExampleView()
        case .calendarWithRangePicker:
            CalendarWithRangePickExampleView()
        case .calendarWithAccessoryView:
            CalendarWithAccessoryViewExampleView()
        }
    }
}

#Preview {
    ContentView()
}
