//
//  CalendarWithCustomHeaderExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXCalendar
import CXUICore
import SwiftUI

// MARK: - CalendarWithCustomHeaderExampleView

struct CalendarWithCustomHeaderExampleView: View {
    var body: some View {
        let template = CXCalendarTemplate.month(.page)
            .builder
//            .calendarHeader { month in
//                CustomMonthHeaderView(month: month)
//            }
            .build()

        CXCalendarView(template: template)
            .navigationTitle("Calendar with Custom Header")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - CustomMonthHeaderView

//struct CustomMonthHeaderView: CXCalendarViewRepresentable {
//    // MARK: Internal
//
//    @Environment(CXCalendarCoordinator.self) var manager
//
//    let date: Date
//
//    var body: some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading) {
//                    monthText
//                    yearText
//                }
//
//                Spacer()
//
//                if manager.shouldBackToStart(date: date) {
//                    resetToTodayButton
//                }
//            }
//            Divider()
//        }
//    }
//
//    // MARK: Private
//
//    private var monthText: some View {
//        Text(month.fullMonth)
//            .font(.headline)
//            .bold()
//            .foregroundColor(monthTextForegroundColor)
//    }
//
//    private var yearText: some View {
//        Text(month.year)
//            .font(.body)
//            .foregroundColor(.secondary)
//    }
//
//    private var monthTextForegroundColor: Color {
//        let isCurrentMonth = calendar.isSameMonthInYear(month, startDate)
//        return isCurrentMonth ? .primary : .secondary
//    }
//
//    private var resetToTodayButton: some View {
//        Button {
//            withAnimation {
//                manager.backToStart()
//            }
//        } label: {
//            Image(systemName: "t.square.fill")
//                .font(.title2)
//                .foregroundColor(.accentColor)
//        }
//    }
//}
//
//#Preview {
//    CalendarWithCustomHeaderExampleView()
//}
