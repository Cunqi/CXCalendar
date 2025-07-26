//
//  TodoGenerator.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/20/25.
//

import Foundation

class TodoGenerator {
    // MARK: Internal

    static let titles = [
        "Organize digital photo library",
        "Schedule annual health checkup",
        "Plan weekend hiking trip",
        "Clean out email inbox",
        "Brainstorm birthday gift ideas",
        "Update LinkedIn profile",
        "Back up important files",
        "Research new productivity apps",
        "Prep meals for the week",
        "Call grandma and catch up",
        "Finish reading current book",
        "Declutter desk drawers",
        "Write a thank-you note",
        "Review monthly budget",
        "Wash car and vacuum interior",
        "Try a new recipe",
        "Plan next vacation destination",
        "Water houseplants",
        "Organize bookshelf by genre",
        "Create playlist for workouts"
    ]

    static let maxDailyTodoCount = 8

    static func generateTodos(for date: Date) -> [Todo] {
        let todos = titles.shuffled()
        let count = Int.random(in: 1 ... maxDailyTodoCount)
        return todos.prefix(count).map { Todo(title: $0, date: date, time: generateTime()) }
    }

    // MARK: Private

    private static func generateTime() -> Date {
        let calendar = Calendar.current
        let hour = Int.random(in: 0 ... 23)
        let minute = Int.random(in: 0 ... 59)
        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
    }
}
