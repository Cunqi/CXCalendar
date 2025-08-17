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
        let template = CXCalendarTemplate.month(.page)
            .builder
            .layoutStrategy(.flexHeight)
            .axis(.vertical)
            .build()

        CXCalendarView(template: template)
            .navigationTitle("Vertical Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal,)
    }
}

#Preview {
    VerticalCalendarExampleView()
}
