//
//  CalendarWithWeekContentTypeExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/18/25.
//

import CXCalendar
import CXLazyPage
import CXUICore
import SwiftUI

struct CalendarWithWeekContentTypeExampleView: View {
    var body: some View {
        let template = CXCalendarTemplate.week()
            .builder
            .build()

        CXCalendarView(template: template)
            .navigationTitle("Scrollable Day Example")
            .navigationBarTitleDisplayMode(.inline)
    }
}
