//
//  CalendarHeaderView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI

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
                if manager.shouldDisplayResetToTodayButton(date: date) {
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
                manager.resetToToday()
            }
        }) {
            Image(systemName: "arrow.turn.up.left")
                .font(.title2)
                .foregroundColor(.accentColor)
        }
    }
}
