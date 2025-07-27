//
//  HorizontalCalendarExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import SwiftUI

struct HorizontalCalendarExampleView: View {
    var body: some View {
        CXCalendarView(context: .year(.scroll))
            .navigationTitle("Horizontal Calendar")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HorizontalCalendarExampleView()
}
