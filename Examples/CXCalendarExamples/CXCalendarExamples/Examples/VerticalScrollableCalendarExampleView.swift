//
//  VerticalScrollableCalendarExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/15/25.
//

import CXCalendar
import SwiftUI

struct VerticalScrollableCalendarExampleView: View {
    @State private var backToToday = false
    var body: some View {
        let context = CXCalendarContext.month(.scroll)

        CXCalendar(context: context, backToToday: $backToToday)
            .navigationTitle("Vertical Continuous Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Today") {
                        backToToday.toggle()
                    }
                }
            }
    }
}
