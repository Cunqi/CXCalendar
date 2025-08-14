//
//  CXCalendarTemplate+Core.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//
import SwiftUI

extension CXCalendarTemplate.Builder {
    // MARK: Public

    public func mode(_ mode: CXCalendarMode) -> CXCalendarTemplate.Builder {
        self.mode = mode
        return self
    }

    public func scrollStrategy(_ scrollStrategy: CXCalendarScrollStrategy) -> CXCalendarTemplate
        .Builder {
        self.scrollStrategy = scrollStrategy
        return self
    }

    public func calendar(_ calendar: Calendar) -> CXCalendarTemplate.Builder {
        self.calendar = calendar
        return self
    }

    public func startDate(_ startDate: Date) -> CXCalendarTemplate.Builder {
        self.startDate = startDate
        return self
    }

    public func selectedDate(_ selectedDate: Date) -> CXCalendarTemplate.Builder {
        self.selectedDate = selectedDate
        return self
    }

    // MARK: Internal

    func makeCore() -> any CXCalendarCoreProtocol {
        CalendarCore(
            mode: mode,
            scrollStrategy: scrollStrategy,
            calendar: calendar,
            startDate: calendar.startOfDay(for: startDate),
            selectedDate: calendar.startOfDay(for: selectedDate)
        )
    }
}
