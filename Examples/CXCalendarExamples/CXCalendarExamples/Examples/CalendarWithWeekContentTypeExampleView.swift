//
//  CalendarWithWeekContentTypeExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/18/25.
//

import CXCalendar
import SwiftUI

struct CalendarWithWeekContentTypeExampleView: View {
    var body: some View {
        let context = CXCalendarContext.paged
            .builder
            .contentType(.week)
            .build()

        CXPagedCalendar(context: context)
        .padding(.horizontal)
        .navigationTitle("Week Content Type")
        .navigationBarTitleDisplayMode(.inline)
    }
}
