//
//  File.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/20/25.
//

import Foundation

extension DateInterval {

    /// Checks if the date interval contains a specific date. excluding the end date.
    /// - Parameters:
    ///   - date: The date to check if it falls within the interval.
    ///   - calendar: The calendar used for date calculations.
    /// - Returns: `true` if the date is within the interval, `false` otherwise.
    public func containsExceptEnd(_ date: Date, calendar: Calendar) -> Bool {
        let startDay = calendar.startOfDay(for: start)
        let lastDay = calendar.startOfDay(for: end)
        let dateDay = calendar.startOfDay(for: date)

        return startDay <= dateDay && dateDay < lastDay
    }

    /// Returns the last day of the date interval in the specified calendar.
    /// - Parameter calendar: The calendar used for date calculations.
    /// - Returns: The last day of the interval, adjusted to the end of the previous day.
    public func lastDay(calendar: Calendar) -> Date {
        calendar.date(byAdding: .day, value: -1, to: end) ?? .now
    }
}
