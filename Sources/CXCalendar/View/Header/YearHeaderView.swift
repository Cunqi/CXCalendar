//
//  YearHeaderView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/26/25.
//

import CXUICore
import SwiftUI

struct YearHeaderView: CXCalendarViewRepresentable {
    @Environment(CXCalendarManager.self) var manager
    let year: Date

    var body: some View {
        VStack(spacing: CXSpacing.oneX) {
            Text(year, format: .dateTime.year())
                .font(.title)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
        }
    }

    private var foregroundColor: Color {
        let isSameYear = calendar.isDate(year, equalTo: startDate, toGranularity: .year)
        return isSameYear ? theme.accentColor : .primary
    }
}
