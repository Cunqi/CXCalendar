//
//  CXCalendarCoordinator+Core.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//
import SwiftUI

extension CXCalendarContext.Builder {
    public func mode(_ mode: CXCalendarMode) -> CXCalendarContext.Builder {
        self.mode = mode
        return self
    }

    public func scrollStrategy(_ scrollStrategy: CXCalendarScrollStrategy) -> CXCalendarContext
        .Builder {
        self.scrollStrategy = scrollStrategy
        return self
    }

    public func calendar(_ calendar: Calendar) -> CXCalendarContext.Builder {
        self.calendar = calendar
        return self
    }

    public func startDate(_ startDate: Date) -> CXCalendarContext.Builder {
        self.startDate = startDate
        return self
    }

    public func selectedDate(_ selectedDate: Date) -> CXCalendarContext.Builder {
        self.selectedDate = selectedDate
        return self
    }

    public func makeCore() -> any CXCalendarCoreProtocol {
        CalendarCore(
            mode: mode,
            scrollStrategy: scrollStrategy,
            calendar: calendar,
            startDate: calendar.startOfDay(for: startDate),
            selectedDate: calendar.startOfDay(for: selectedDate)
        )
    }
}
