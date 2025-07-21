//
//  CalendarHeaderView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI

/// The `CalendarHeaderView` is a SwiftUI view that displays the header of a calendar, including the month and year, and a button to reset to today's date if applicable.
/// it is the default implementation of the header view for `CXCalendar`.
struct CalendarHeaderView: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let date: Date

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    monthText
                    yearText
                }
                Spacer()
                if manager.shouldBackToStart(date: date) {
                    navTodayButton
                }
            }
            Divider()
            compose.weekHeader(date).erased
        }
    }

    // MARK: Private

    private var monthText: some View {
        Text(date.fullMonth)
            .font(.headline)
            .bold()
            .foregroundColor(.primary)
    }

    private var yearText: some View {
        Text(date.year)
            .font(.body)
            .foregroundColor(.secondary)
    }

    private var navTodayButton: some View {
        Button(action: {
            withAnimation {
                manager.backToStart()
            }
        }) {
            Image(systemName: "arrow.turn.up.left")
                .font(.title2)
                .foregroundColor(.accentColor)
        }
    }
}
