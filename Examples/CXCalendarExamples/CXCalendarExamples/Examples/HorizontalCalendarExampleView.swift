//
//  HorizontalCalendarExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import SwiftUI

struct HorizontalCalendarExampleView: View {
    @State private var selectedDate = Date.now
    var body: some View {
        VStack {
            CXCalendarView(template: .month(.page))
                .padding(.horizontal)
                .navigationTitle("Horizontal Calendar")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HorizontalCalendarExampleView()
}
