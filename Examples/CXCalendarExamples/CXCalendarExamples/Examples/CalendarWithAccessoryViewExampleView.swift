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

struct CalendarWithAccessoryViewExampleView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        let context = CXCalendarContext.paged.builder
            .accessoryView { day in
                AccessoryView(day: day, items: viewModel.items)
                    .onAppear {
                        viewModel.updateItems(for: day)
                    }
                    .onChange(of: day) { oldValue, newValue in
                        viewModel.updateItems(for: day)
                    }
            }
            .build()

        CXPagedCalendar(context: context)
            .padding(.horizontal)
            .navigationTitle("Calendar with Accessory View")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AccessoryView: View {
    let day: Date
    let items: [ActionItem]

    var body: some View {
        ScrollView {
            VStack(spacing: CXSpacing.halfX) {
                Text("Actions for \(day.formatted(.dateTime.month().day().year()))")
                    .font(.headline)
                ForEach(items) { item in
                    HStack {
                        Text(item.title)
                            .font(.headline)
                            .foregroundColor(.primary)

                        Spacer()

                        Text(item.time)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(item.backgroundColor)
                    .cornerRadius(CXSpacing.halfX)
                }
            }
        }
        .onAppear {
            print("Accessory view appeared for \(day.formatted(.dateTime.month().day().year()))")
        }
    }
}

extension CalendarWithAccessoryViewExampleView {
    @Observable
    class ViewModel {
        var items: [ActionItem] = []

        func updateItems(for date: Date) {
            items = (0 ..< 10).map { index in
                ActionItem(
                    title: "Action \(Int.random(in: 0 ..< abs(date.hashValue) % 100))",
                    time: "\(index + 1) hour(s) ago",
                    backgroundColor: Color(hue: Double(index) / 10.0, saturation: 0.8, brightness: 0.8)
                )
            }
        }
    }
}

struct ActionItem: Identifiable {
    let id = UUID()

    let title: String
    let time: String
    let backgroundColor: Color
}
