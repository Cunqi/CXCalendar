//
//  CalendarWithWeekContentTypeExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/18/25.
//

import CXCalendar
import CXFoundation
import CXLazyPage
import SwiftUI

struct CalendarWithWeekContentTypeExampleView: View {
    var body: some View {
        let context = CXCalendarContext.week()
            .builder
            .accessoryView { day in
                ScrollableDayView(date: day)
            }
            .build()

        CXCalendar(context: context)
            .navigationTitle("Scrollable Day Example")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - ScrollableDayView

struct ScrollableDayView: CXCalendarViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    var days: [IdentifiableDate] {
        manager.makeDays(from: manager.currentDateInterval)
    }

    var day: Date

    @State private var focusedDate: Date

    init(date: Date) {
        self.day = date
        self.focusedDate = date
    }

    var body: some View {
        TabView(selection: $focusedDate) {
            ForEach(days) { day in
                Text(day.value, format: .dateTime.day())
                    .tag(day.value)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: focusedDate) { oldValue, newValue in
            manager.selectedDate = newValue
        }
        .onChange(of: manager.selectedDate) { oldValue, newValue in
            if !calendar.isSameDay(newValue, focusedDate) {
                focusedDate = newValue
            }
        }
    }
}
