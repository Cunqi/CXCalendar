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
        let context = CXCalendarContext.paged.builder
            .axis(.vertical)
            .build()

        CXPagedCalendar(context: context)
            .padding(.horizontal)
            .navigationTitle("Vertical Calendar")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    VerticalCalendarExampleView()
}
