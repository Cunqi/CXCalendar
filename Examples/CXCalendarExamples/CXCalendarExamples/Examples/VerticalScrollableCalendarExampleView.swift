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
        let context = CXCalendarContext.scrollable.builder
            .build()

        CXScrollableCalendar(context: context, backToToday: $backToToday)
            .padding(.horizontal)
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
