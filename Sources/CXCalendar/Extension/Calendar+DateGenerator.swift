//
//  Calendar+MonthGrid.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import Foundation

extension Calendar {

    // MARK: Internal

    /// Generate month grid dates with leading and trailing dates in fix 42 cells.
    /// - Parameter monthInterval: month interval for current month
    /// - Returns: an array of `IdentifiableDate` representing the month grid with fixed 42 cells.
    func makeFixedMonthGridDates(from monthInterval: DateInterval) -> [IdentifiableDate] {
        let firstDay = monthInterval.start

        let lead = (component(.weekday, from: firstDay) - firstWeekday + 7) % 7
        let gridStart = date(byAdding: .day, value: -lead, to: firstDay)!

        return Calendar.gridRange.compactMap { index in
            guard let day = date(byAdding: .day, value: index, to: gridStart) else {
                return nil
            }
            return IdentifiableDate(value: day, id: index)
        }
    }

    /// Generates a dynamic month grid of dates based on the provided month interval. the size of the grid
    /// is determined by the number of weeks in the month, which can vary.
    /// - Parameter monthInterval: The date interval representing the month for which to generate the grid.
    /// - Returns: An array of `IdentifiableDate` representing the dates in the month grid.
    func makeDynamicMonthGridDates(from monthInterval: DateInterval) -> [IdentifiableDate] {
        let firstDay = monthInterval.start
        let lastDay = date(byAdding: .day, value: -1, to: monthInterval.end)!

        guard
            let startWeekInterval = dateInterval(of: .weekOfMonth, for: firstDay),
            let endWeekInterval = dateInterval(of: .weekOfMonth, for: lastDay)
        else {
            return []
        }

        let startDate = startWeekInterval.start
        let endDate = endWeekInterval.end

        var result = [IdentifiableDate]()
        var current = startDate
        var index = 0

        while current < endDate {
            result.append(IdentifiableDate(value: current, id: index))

            guard let next = date(byAdding: .day, value: 1, to: current) else {
                break
            }
            index += 1
            current = next
        }

        return result
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
