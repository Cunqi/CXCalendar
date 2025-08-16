//
//  ActivityTracker.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 8/15/25.
//

import CXCalendar
import CXUICore
import Observation
import SwiftUI

// MARK: - ActivityTrackerView

struct ActivityTrackerView: View {
    // MARK: Internal

    var body: some View {
        VStack {
            calendarView
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.red)
                }
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.systemGroupedBackground)
    }

    // MARK: Private

    @State private var viewModel = ViewModel()

    @ViewBuilder
    private var calendarView: some View {
        let template = CXCalendarTemplate.month()
            .builder
            .calendarHeader { date in
                ATCalendarHeader(date: date)
            }
            .build()

        CXCalendarView(template: template)
    }
}

// MARK: ActivityTrackerView.ViewModel

extension ActivityTrackerView {
    @Observable
    final class ViewModel {
        // MARK: Lifecycle

        init() {
            activities = ActivityGenerator.generate(count: 100)
        }

        // MARK: Internal

        var activities: [Activity] = []
    }
}
