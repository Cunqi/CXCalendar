//
//  File.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import Foundation

extension DateInterval {
    func containsDay(_ date: Date, calendar: Calendar) -> Bool {
        let startDay = calendar.startOfDay(for: start)
        let lastDay = calendar.startOfDay(for: end)
        let dateDay = calendar.startOfDay(for: date)

        return startDay <= dateDay && dateDay < lastDay
    }

    func lastDay(calendar: Calendar) -> Date {
        calendar.date(byAdding: .day, value: -1, to: end) ?? .now
    }
}
