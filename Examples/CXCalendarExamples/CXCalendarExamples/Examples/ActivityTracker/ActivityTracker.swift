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
    @State private var selectedDate = Date.now
    // MARK: Internal

    var body: some View {
        VStack {
            CXCalendarMonthViewer(selectedDate: $selectedDate, selectFirstDayByDefault: true)
                .frame(width: 320)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.secondarySystemGroupedBackground)
                }
            Spacer()
            ActivityView(date: selectedDate)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.systemGroupedBackground)
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

        func items(for date: Date) -> [Activity] {
            return activities.filter {
                Calendar.current.isDate($0.createdAt, inSameDayAs: date)
            }
        }
    }
}

extension ActivityTrackerView {
    struct ActivityView: View {
        @State private var viewModel = ViewModel()

        let date: Date

        var items: [Activity] {
            viewModel.items(for: date)
        }

        var body: some View {
            List {
                ForEach(items) { item in
                    Text(item.name)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .listRowInsets(EdgeInsets())
                }
            }
            .cornerRadius(10.0)
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .background {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.secondarySystemGroupedBackground)
            }
            .padding(.top)
        }
    }
}
