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
        CXCalendar(context: CXCalendarContext.week())
            .navigationTitle("Week Content Type")
            .navigationBarTitleDisplayMode(.inline)
    }
}
