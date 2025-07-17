//
//  CalendarHeaderView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI

struct CalendarHeaderView: CXCalendarHeaderViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    monthText
                    yearText
                }
                Spacer()
                if manager.shouldDisplayResetToTodayButton(month: month) {
                    navTodayButton
                }
            }
            Divider()
            WeekHeaderView(month: month)
        }
    }

    private var monthText: some View {
        Text(month.fullMonth)
            .font(.headline)
            .bold()
            .foregroundColor(.primary)
    }

    private var yearText: some View {
        Text(month.year)
            .font(.body)
            .foregroundColor(.secondary)
    }

    private var navTodayButton: some View {
        Button(action: {
            withAnimation {
                manager.resetToToday()
            }
        }) {
            Image(systemName: "arrow.turn.up.left")
                .font(.title2)
                .foregroundColor(.accentColor)
        }
    }
}
