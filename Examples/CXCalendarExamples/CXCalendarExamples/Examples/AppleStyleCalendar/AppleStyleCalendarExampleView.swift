//
//  AppleStyleCalendarExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/25/25.
//

import CXCalendar
import SwiftUI

struct AppleStyleCalendarExampleView: View {
    let context = CXCalendarContext.month(.scroll)
        .builder
        .build()

    var body: some View {
        CXCalendarView(context: context)
            .navigationBarTitleDisplayMode(.inline)
    }
}
