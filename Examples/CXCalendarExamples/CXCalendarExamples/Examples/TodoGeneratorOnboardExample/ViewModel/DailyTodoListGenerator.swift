//
//  DailyTodoListGenerator.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXFoundation
import Foundation

class DailyTodoListGenerator {
    // MARK: Internal

    func generateTodos(from startDate: Date, to endDate: Date) -> [DailyTodoList] {
        let numberOfDays = numberOfDays(from: startDate, to: endDate)
        let maxDailyTodoCount = Int(Double(numberOfDays) * 0.67)
        let dates = DailyTodoListGenerator.randomDates(
            in: DateInterval(start: startDate, end: endDate),
            count: maxDailyTodoCount
        )

        return dates.map { date in
            DailyTodoList(
                date: IdentifiableDate(value: date, id: date.fullDate),
                todos: TodoGenerator.generateTodos(for: date)
            )
        }
    }

    // MARK: Private

    private static func randomDates(
        in monthInterval: DateInterval,
        count: Int,
        calendar: Calendar = .current
    ) -> [Date] {
        let startDate = calendar.startOfDay(for: monthInterval.start)
        let endDate = calendar.startOfDay(for: monthInterval.end)

        guard let totalDays = calendar.dateComponents([.day], from: startDate, to: endDate).day,
              totalDays >= count else {
            return []
        }

        var allDates: [Date] = (0 ... totalDays).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startDate)
        }
        allDates.shuffle()
        return Array(allDates.prefix(count))
    }

    private func numberOfDays(from startDate: Date, to endDate: Date) -> Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }
}
