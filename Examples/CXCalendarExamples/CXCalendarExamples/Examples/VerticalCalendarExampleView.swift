//
//  VerticalCalendarExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import SwiftUI

struct VerticalCalendarExampleView: View {
    var body: some View {
        let template = CXCalendarTemplate.month(.scroll)
            .builder
            .build()

        CXCalendarView(template: template)
            .navigationTitle("Vertical Calendar")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    VerticalCalendarExampleView()
}
