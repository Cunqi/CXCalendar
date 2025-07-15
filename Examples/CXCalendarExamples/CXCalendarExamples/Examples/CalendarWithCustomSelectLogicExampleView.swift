//
//  CalendarWithCustomSelectLogicExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXFoundation
import SwiftUI

struct CalendarWithCustomSelectLogicExampleView: View {
    @State private var selectedDate: Date? = nil

    var body: some View {
        let context = CXCalendarContext.Builder()
            .canSelect { month, day, calendar in
                calendar.isSameMonthInYear(month, day)
            }
            .build()

        CXCalendarView(context: context)
        .padding(.horizontal)
        .navigationTitle("Custom Select Logic Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }
}
