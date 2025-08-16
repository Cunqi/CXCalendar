//
//  HorizontalCalendarExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXLazyPage
import SwiftUI

struct HorizontalCalendarExampleView: View {
    // MARK: Internal

    var template: CXCalendarTemplate {
        CXCalendarTemplate.month()
            .builder
            .layoutStrategy(.square)
            .onCalendarItemSelect { date in
                selectedDate = date
            }
            .build()
    }

    var body: some View {
        VStack {
            CXCalendarView(template: template)
                .padding(.horizontal)
                .navigationTitle("Horizontal Calendar")
                .navigationBarTitleDisplayMode(.inline)

            Text("Selected Date: \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                .padding()
                .foregroundColor(.primary)
                .font(.title)
        }
    }

    // MARK: Private

    @State private var selectedDate = Date.now
}

#Preview {
    HorizontalCalendarExampleView()
}
