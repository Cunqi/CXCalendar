//
//  File.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXFoundation
import SwiftUI
import Observation

@Observable
@MainActor
public class CXCalendarManager {

    // MARK: - Public properties

    public let context: CXCalendarContext

    public let startDate: Date

    public var selectedDate: Date?

    public var currentDate: Date {
        makeMonthFromStart(offset: currentPage)
    }

    let columns: [GridItem]

    var currentPage: Int = 0

    // MARK: - Initializer

    init(context: CXCalendarContext) {
        self.context = context
        self.columns = Array(repeating: GridItem(.flexible(), spacing: context.layout.columnPadding), count: 7)

        self.startDate = context.startDate
        self.selectedDate = context.selectedDate
    }

    // MARK: - Public Methods
    
    /// Determines whether the reset to today button should be displayed for a given month.
    /// - This method checks if the given month has the same month and year as the start date,
    ///  and whether the selected date is today.
    ///
    /// If the month is not the same as the start month and year, or if the selected date is not today,
    /// the button should be displayed.
    ///
    /// - Parameter month: The month to check, represented as a `Date`.
    /// - Returns: A Boolean value indicating whether the reset to today button should be displayed.
    public func shouldDisplayResetToTodayButton(month: Date) -> Bool {
        let isInStartMonthAndYear = context.calendar.isSameMonthInYear(startDate, month)
        let isTodaySelected = if let selectedDate {
            context.calendar.isSameDay(selectedDate, startDate)
        } else {
            true
        }
        return !isInStartMonthAndYear || !isTodaySelected
    }

    public func resetToToday() {
        currentPage = 0
        if selectedDate != nil {
            selectedDate = startDate
        }
    }

    // MARK: - Internal Methods

    func makeMonthFromStart(offset: Int) -> Date {
        context.calendar.date(byAdding: .month, value: offset, to: startDate)!
    }

    func makeMonthGridDates(for month: Date) -> [IdentifiableDate] {
        guard let monthInterval = context.calendar.dateInterval(of: .month, for: month) else {
            return []
        }

        switch context.style {
        case .paged:
            return context.calendar.makeFixedMonthGridDates(from: monthInterval)
        case .scrollable:
            return context.calendar.makeDynamicMonthGridDates(from: monthInterval)
        }
    }

    func numberOfRows(for index: Int) -> Int {
        context.calendar.numberOfWeeks(inMonthOf: makeMonthFromStart(offset: index)) + 1 // +1 for month header
    }
}

