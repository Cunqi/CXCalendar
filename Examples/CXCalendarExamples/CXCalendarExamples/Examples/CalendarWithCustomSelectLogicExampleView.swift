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
        let context = CXCalendarContext.paged
            .builder
            .canSelect { dateInterval, day, _ in
                dateInterval.contains(day)
            }
            .build()

        CXPagedCalendar(context: context)
            .padding(.horizontal)
            .navigationTitle("Custom Select Logic Calendar")
            .navigationBarTitleDisplayMode(.inline)
    }
}
