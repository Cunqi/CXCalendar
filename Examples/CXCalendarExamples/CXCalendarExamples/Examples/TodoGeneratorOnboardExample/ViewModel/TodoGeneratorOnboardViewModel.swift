//
//  TodoGeneratorOnboardViewModel.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/20/25.
//

import Foundation
import Observation

@Observable
class TodoGeneratorOnboardViewModel {
    // MARK: Internal

    var interval: DateInterval?

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

    // MARK: Private

    private var isPickingFirst = true
}
