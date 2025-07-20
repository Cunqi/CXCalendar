//
//  MonthHeaderView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

struct MonthHeaderView: CXCalendarViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let month: Date

    var body: some View {
        HStack {
            Text(month.fullMonth)
                .font(.headline)
                .foregroundColor(.primary)
            Text(month.year)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
