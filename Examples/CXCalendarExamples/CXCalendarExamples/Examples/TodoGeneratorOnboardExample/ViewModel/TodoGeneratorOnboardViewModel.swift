//
//  TodoGeneratorOnboardViewModel.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXFoundation
import Foundation
import Observation

@Observable
class TodoGeneratorOnboardViewModel {
    // MARK: Internal

    var interval: DateInterval?

    var todos: [DailyTodoList] = []

    var detailDate: Date?

    func pick(date: Date) {
        if isPickingFirst {
            interval = DateInterval(start: date, end: date)
        } else if let interval {
            let start = min(interval.start, date)
            let end = max(interval.end, date)
            self.interval = DateInterval(start: start, end: end)
        }
        isPickingFirst.toggle()
    }

    func isInRange(_ date: Date) -> Bool {
        guard let interval else {
            return false
        }
        return interval.contains(date)
    }

    func generateTodo() {
        guard let interval else {
            return
        }
        todos = DailyTodoListGenerator().generateTodos(from: interval.start, to: interval.end)
    }

    func isInTodoList(_ date: Date, calendar: Calendar) -> Bool {
        guard !todos.isEmpty else {
            return false
        }
        return todos.contains { calendar.isSameDay($0.date.value, date) }
    }

    func fetchDailyTodoList(for date: Date, calendar: Calendar) -> DailyTodoList? {
        todos.first(where: { calendar.isSameDay($0.date.value, date) })
    }

    // MARK: Private

    private var isPickingFirst = true
}
