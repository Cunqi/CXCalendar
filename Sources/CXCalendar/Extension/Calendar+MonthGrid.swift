//
//  Calendar+MonthGrid.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import Foundation

extension Calendar {

    /// Fix generated grid into 6 rows × 7 columns (42 cells)
    private static let gridRange = 0 ..< 42

    /// Generate month grid dates with leading and trailing dates in fix 42 cells.
    /// - Parameter monthInterval: month interval for current month
    /// - Returns: an array of `IdentifiableDate` representing the month grid with fixed 42 cells.
    func makeMonthGridDates(from monthInterval: DateInterval) -> [IdentifiableDate] {
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
}
