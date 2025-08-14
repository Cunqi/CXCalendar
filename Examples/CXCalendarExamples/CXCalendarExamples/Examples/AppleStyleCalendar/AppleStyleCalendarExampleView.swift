//
//  AppleStyleCalendarExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/25/25.
//

import CXCalendar
import SwiftUI

struct AppleStyleCalendarExampleView: View {
    let template = CXCalendarTemplate.month(.scroll)
        .builder
        .build()

    var body: some View {
        CXCalendarView(template: template)
            .navigationBarTitleDisplayMode(.inline)
    }
}
