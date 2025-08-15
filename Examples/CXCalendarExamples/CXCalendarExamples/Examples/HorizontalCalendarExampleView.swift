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

    var template: CXCalendarTemplate {
        CXCalendarTemplate.month()
        .builder
        .onCalendarItemSelect { date in
            self.selectedDate = date
        }
        .build()
    }

    var body: some View {
        VStack {
            CXCalendarView(template: template)
                .padding(.horizontal)
                .navigationTitle("Horizontal Calendar")
                .navigationBarTitleDisplayMode(.inline)

            Spacer()

            Text("Selected Date: \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                .padding()
                .foregroundColor(.primary)
                .font(.title)
        }
    }
}

#Preview {
    HorizontalCalendarExampleView()
}
