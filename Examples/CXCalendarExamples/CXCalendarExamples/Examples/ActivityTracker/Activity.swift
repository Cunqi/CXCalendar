//
//  Activity.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 8/15/25.
//

import Foundation

// MARK: - Activity

struct Activity {
    let name: String
    let isCompleted: Bool
    let createdAt: Date
}

// MARK: - ActivityGenerator

enum ActivityGenerator {
    static let sampleNames = [
        "Read a book",
        "Go jogging",
        "Meditate",
        "Cook dinner",
        "Study Swift",
        "Write a journal",
        "Call a friend",
        "Clean the house",
        "Watch a movie",
        "Practice guitar"
    ]

    static func randomActivity() -> Activity {
        let now = Date()
        let calendar = Calendar.current

        let startDate = calendar.date(byAdding: .month, value: -1, to: now)!
        let endDate = calendar.date(byAdding: .month, value: 1, to: now)!

        let randomTimeInterval = TimeInterval.random(
            in: startDate.timeIntervalSince1970 ... endDate.timeIntervalSince1970
        )
        let randomDate = Date(timeIntervalSince1970: randomTimeInterval)

        return Activity(
            name: sampleNames.randomElement() ?? "Untitled",
            isCompleted: Bool.random(),
            createdAt: randomDate
        )
    }

    static func generate(count: Int) -> [Activity] {
        (0 ..< count).map { _ in randomActivity() }
    }
}
