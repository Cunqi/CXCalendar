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
        let context = CXCalendarContext.month(.page)

        CXCalendar(context: context)
            .navigationTitle("Week Content Type")
            .navigationBarTitleDisplayMode(.inline)
    }
}
