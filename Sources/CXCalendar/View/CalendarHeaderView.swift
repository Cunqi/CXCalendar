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
            weekdaysBar
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

    private var weekdaysBar: some View {
        LazyVGrid(columns: manager.columns, spacing: manager.context.rowPadding) {
            let titles = manager.context.weekdayTitles
            ForEach(titles.indices, id: \.self) { index in
                Text(titles[index])
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
