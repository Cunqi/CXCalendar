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
    // MARK: Internal

    var body: some View {
        let template = CXCalendarTemplate.month(.page)
            .builder
            .build()

        CXCalendarView(template: template)
            .navigationTitle("Custom Select Logic Calendar")
            .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: Private

    @State private var selectedDate: Date? = nil
}
