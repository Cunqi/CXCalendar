//
//  HorizontalCalendarExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import SwiftUI
import CXLazyPage

struct HorizontalCalendarExampleView: View {
    @State private var selectedDate: Date? = Date.now

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

            if let selectedDate {
                Text("Selected Date: \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                    .padding()
                    .foregroundColor(.primary)
                    .font(.title)
            }
        }
    }
}

#Preview {
    HorizontalCalendarExampleView()
}
