//
//  VerticalScrollableCalendarExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/15/25.
//

import CXCalendar
import SwiftUI

struct VerticalScrollableCalendarExampleView: View {
    var body: some View {
        CXCalendarView(template: .month(.scroll))
            .navigationTitle("Vertical Continuous Calendar")
            .navigationBarTitleDisplayMode(.inline)
    }
}
