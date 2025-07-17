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
        let context = CXCalendarContext.scrollable.builder
            .build()

        CXScrollableCalendar(context: context)
            .padding(.horizontal)
            .navigationTitle("Vertical Continuous Calendar")
            .navigationBarTitleDisplayMode(.inline)
    }
}
