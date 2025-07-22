//
//  Calendar+MonthGrid.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

extension Calendar {
    // MARK: Internal

    /// Generate month grid dates with leading and trailing dates in fix 42 cells.
    /// - Parameter monthInterval: month interval for current month
    /// - Returns: an array of `IndexedDate` representing the month grid with fixed 42 cells.
    func makeFixedMonthGridDates(from monthInterval: DateInterval) -> [IndexedDate] {
        let firstDay = monthInterval.start
        let lead = (component(.weekday, from: firstDay) - firstWeekday + 7) % 7
        let gridStart = date(byAdding: .day, value: -lead, to: firstDay)!

        return Calendar.gridRange.compactMap { index in
            date(byAdding: .day, value: index, to: gridStart).map { IndexedDate(
                value: $0,
                id: index
            ) }
        }
    }

    /// Generates a dynamic month grid of dates based on the provided month interval. the size of the grid
    /// is determined by the number of weeks in the month, which can vary.
    /// - Parameter monthInterval: The date interval representing the month for which to generate the grid.
    /// - Returns: An array of `IndexedDate` representing the dates in the month grid.
    func makeDynamicMonthGridDates(from monthInterval: DateInterval) -> [IndexedDate] {
        guard let weekInterval = dateInterval(of: .weekOfMonth, for: monthInterval.start) else {
            return []
        }

        var result = [IndexedDate]()
        var current = weekInterval.start
        var index = 0

        while current < monthInterval.end {
            result.append(IndexedDate(value: current, id: index))
            guard let next = date(byAdding: .day, value: 1, to: current) else {
                break
            }
            current = next
            index += 1
        }

        return result
    }

    /// Generates a fixed week grid of dates based on the provided week interval.
    /// - Parameter weekInterval: The date interval representing the week for which to generate the grid.
    /// - Returns: An array of `IdentifiableDate` representing the dates in the week grid.
    func makeFixedWeekGridDates(from weekInterval: DateInterval) -> [IndexedDate] {
        var day = weekInterval.start
        var result = [IndexedDate]()
        var index = 0
        while day < weekInterval.end {
            result.append(IndexedDate(value: day, id: index))
            guard let nextDay = date(byAdding: .day, value: 1, to: day) else {
                break
            }
            day = nextDay
            index += 1
        }
        return result
    }

    /// Calculates the offset in a specified calendar component between two dates.
    /// - Parameters:
    ///   - date1: The first date for comparison.
    ///   - date2: The second date for comparison.
    ///   - component: The calendar component to use for the offset calculation. Default is `.day`.
    /// - Returns: The offset as an integer value for the specified component.
    func offset(
        between date1: Date,
        and date2: Date,
        by component: Calendar.Component = .day
    ) -> Int {
        let startOfDay1 = startOfDay(for: date1)
        let startOfDay2 = startOfDay(for: date2)
        let dateComponents = dateComponents([component], from: startOfDay1, to: startOfDay2)
        return dateComponents.value(for: component) ?? 0
    }

    /// Calculates the number of weeks in the month of a given date.
    /// - Parameter date: The date for which to calculate the number of weeks in its month.
    /// - Returns: The number of weeks in the month of the specified date.
    func numberOfWeeks(inMonthOf date: Date) -> Int {
        guard let monthInterval = dateInterval(of: .month, for: date) else {
            return 0
        }

        let startOfMonth = monthInterval.start
        let endOfMonth = self.date(byAdding: .day, value: -1, to: monthInterval.end)!

        let startWeek = component(.weekOfYear, from: startOfMonth)
        let endWeek = component(.weekOfYear, from: endOfMonth)

        // If the start week is greater than the end week, it means the month spans across two years.
        if endWeek < startWeek {
            let year = component(.yearForWeekOfYear, from: startOfMonth)
            let weeksInYear = range(
                of: .weekOfYear,
                in: .yearForWeekOfYear,
                for: self.date(from: DateComponents(year: year))!
            )?.count ?? 52
            return (weeksInYear - startWeek + 1) + endWeek
        }

        return endWeek - startWeek + 1
    }

    // MARK: Private

    /// Fix generated grid into 6 rows × 7 columns (42 cells)
    private static let gridRange = 0 ..< 42
}
