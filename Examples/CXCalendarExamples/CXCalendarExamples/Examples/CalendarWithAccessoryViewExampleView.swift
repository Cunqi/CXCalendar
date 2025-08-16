//
//  CalendarWithAccessoryViewExampleView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/14/25.
//

import CXCalendar
import CXUICore
import Observation
import SwiftUI

// MARK: - CalendarWithAccessoryViewExampleView

struct CalendarWithAccessoryViewExampleView: View {
    // MARK: Internal

    var body: some View {
        var template: CXCalendarTemplate {
            CXCalendarTemplate.month(.page)
                .builder
                .hPadding(.zero)
                .layoutStrategy(.fixedHeight(32))
                .accessoryView { date in
                    AccessoryView(date: date)
                }
                .build()
        }

        VStack {
            CXCalendarView(template: template)
                .navigationTitle("Calendar with Accessory View")
                .navigationBarTitleDisplayMode(.inline)
                .environment(viewModel)
        }
    }

    // MARK: Private

    @State private var viewModel = CalendarWithAccessoryViewExampleView.ViewModel()
}

// MARK: CalendarWithAccessoryViewExampleView.AccessoryView

extension CalendarWithAccessoryViewExampleView {
    struct AccessoryView: View {
        @Environment(CalendarWithAccessoryViewExampleView.ViewModel.self) var viewModel

        let date: Date

        var items: [ActionItem] {
            viewModel.makeItems(for: date)
        }

        var body: some View {
            VStack {
                Text(date, format: .dateTime.day().month(.wide))
                    .font(.body)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, CXSpacing.oneX)
                    .background {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color.secondarySystemGroupedBackground)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                List {
                    ForEach(items) { item in
                        Text(item.title)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .cornerRadius(10.0)
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            }
            .background(Color.systemGroupedBackground)
        }
    }
}

// MARK: CalendarWithAccessoryViewExampleView.ViewModel

extension CalendarWithAccessoryViewExampleView {
    @Observable
    class ViewModel {
        static let titles = [
            "Design System",
            "Accessibility",
            "Performance",
            "Animations",
            "Testing",
            "Documentation",
            "User Experience",
            "Code Review",
            "Deployment"
        ]

        var items: [ActionItem] = []

        func makeItems(for _: Date) -> [ActionItem] {
            ViewModel.titles.shuffled().map {
                ActionItem(title: $0)
            }
        }
    }
}

// MARK: - ActionItem

struct ActionItem: Identifiable {
    let id = UUID()

    let title: String
}
