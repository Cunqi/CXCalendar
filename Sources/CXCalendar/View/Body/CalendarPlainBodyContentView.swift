//
//  CalendarPlainBodyContentView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXFoundation
import SwiftUI

struct CalendarPlainBodyContentView: CXCalendarBodyContentViewRepresentable {
    @Environment(CXCalendarManager.self) var manager

    let date: Date

    var body: some View {
        VStack {
            Text(date, format: .dateTime)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
