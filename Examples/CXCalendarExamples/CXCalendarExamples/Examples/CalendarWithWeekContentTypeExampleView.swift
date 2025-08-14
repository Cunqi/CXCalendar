//
//  CalendarWithWeekContentTypeExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/18/25.
//

import CXCalendar
import CXLazyPage
import CXUICore
import SwiftUI

struct CalendarWithWeekContentTypeExampleView: View {
    var body: some View {
        let context = CXCalendarCoordinator.week()
            .builder
            .accessoryView { date in
                CXCalendarWeeklyAccessoryWrapperView(date: date) { date, manager in
                    Text(date, format: .dateTime.day().month())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: CXSpacing.oneX)
                                .fill(.blue.opacity(0.2))
                        }
                        .padding(.horizontal, manager.context.layout.calendarHPadding)
                }
            }
            .build()

        CXCalendarView(context: context)
            .navigationTitle("Scrollable Day Example")
            .navigationBarTitleDisplayMode(.inline)
    }
}
