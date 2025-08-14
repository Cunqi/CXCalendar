//
//  CXCalendarSizeCoordinator.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation
import Observation

// MARK: - CXCalendarSizeCoordinator

@MainActor
@Observable
public class CXCalendarSizeCoordinator {
    // MARK: Lifecycle

    init(
        calendarMode: CXCalendarMode,
        itemLayoutStrategy: CXCalendarItemLayoutStrategry,
        hPadding: CGFloat,
        vPadding: CGFloat
    ) {
        self.calendarMode = calendarMode
        self.itemLayoutStrategy = itemLayoutStrategy
        self.hPadding = hPadding
        self.vPadding = vPadding
    }

    // MARK: Internal

    let calendarMode: CXCalendarMode
    let itemLayoutStrategy: CXCalendarItemLayoutStrategry
    let hPadding: CGFloat
    let vPadding: CGFloat

    var itemHeight = CGFloat.zero
    var calendarHeight = CGFloat.zero

    func calculateHeightForPageStrategy(with maxSize: CGSize) {
        let itemWidth = calculateItemWidth(maxWidth: maxSize.width)

        let idealItemHeight = switch itemLayoutStrategy {
        case .square:
            itemWidth
        case .fixedHeight(let height):
            height
        case .flexHeight:
            maxSize.height
        }

        let totalPaddingHeight = vPadding * (calendarMode.numOfRows - 1)
        let totalIdealItemHeight = idealItemHeight * calendarMode.numOfRows
        let totalExpectedHeight = totalIdealItemHeight + totalPaddingHeight

        if totalExpectedHeight > maxSize.height {
            calendarHeight = maxSize.height
            itemHeight = (maxSize.height - totalPaddingHeight) / calendarMode.numOfRows
        } else {
            calendarHeight = totalExpectedHeight
            itemHeight = idealItemHeight
        }
    }

    // MARK: Private

    private func calculateItemWidth(maxWidth: CGFloat) -> CGFloat {
        let totalPaddingWidth = hPadding * (calendarMode.numOfCols - 1)
        let availableWidth = maxWidth - totalPaddingWidth
        return availableWidth / calendarMode.numOfCols
    }
}
