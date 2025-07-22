//
//  Todo.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/20/25.
//

import CXFoundation
import Foundation

struct Todo: Identifiable, Hashable {
    // MARK: Lifecycle

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, date: Date, time: Date) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.date = IdentifiableDate(value: date, id: date.fullDate)
        self.time = time
    }

    // MARK: Internal

    let id: UUID
    let title: String
    let isCompleted: Bool
    let date: IdentifiableDate
    let time: Date

    static func == (lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(isCompleted)
        hasher.combine(date.value)
        hasher.combine(time)
    }
}
