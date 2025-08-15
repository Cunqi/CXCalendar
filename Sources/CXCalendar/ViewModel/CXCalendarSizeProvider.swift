//
//  CXCalendarSizeController.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation
import Observation

// MARK: - CXCalendarSizeCoordinator

@MainActor
@Observable
public class CXCalendarSizeProvider {
    // MARK: Lifecycle

    init(
        calendarMode: CXCalendarMode,
        scrollStrategy: CXCalendarScrollStrategy,
        layoutStrategy: CXCalendarLayoutStrategy,
        itemLayoutStrategy: CXCalendarItemLayoutStrategy,
        hPadding: CGFloat,
        vPadding: CGFloat
    ) {
        self.calendarMode = calendarMode
        self.scrollStrategy = scrollStrategy
        self.layoutStrategy = layoutStrategy
        self.itemLayoutStrategy = itemLayoutStrategy
        self.hPadding = hPadding
        self.vPadding = vPadding
    }

    // MARK: Internal

    let calendarMode: CXCalendarMode
    let scrollStrategy: CXCalendarScrollStrategy
    let layoutStrategy: CXCalendarLayoutStrategy
    let itemLayoutStrategy: CXCalendarItemLayoutStrategy
    let hPadding: CGFloat
    let vPadding: CGFloat

    var itemWidth = CGFloat.zero
    var itemHeight = CGFloat.zero
    var calendarHeight = CGFloat.zero

    func calculateHeightForPageStrategy(with maxSize: CGSize) {
        itemWidth = calculateItemWidth(maxWidth: maxSize.width)

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

        if layoutStrategy == .flex {
            calendarHeight = maxSize.height
        }
    }

    func calculateHeightForScrollStrategy(with maxSize: CGSize) {
        calendarHeight = maxSize.height

        itemWidth = calculateItemWidth(maxWidth: maxSize.width)
        switch itemLayoutStrategy {
        case .square, .flexHeight:
            itemHeight = itemWidth
        case .fixedHeight(let height):
            itemHeight = height
        }
    }

    func calculatePageHeight(at index: Int, numOfRows: Int) -> CGFloat {
        if let cachedHeight = cachedPageHeight[index] {
            return cachedHeight
        }

        var pageHeight = CGFloat.zero

        let totalPaddingHeight = vPadding * (calendarMode.numOfRows - 1)
        pageHeight += totalPaddingHeight

        let totalItemHeight = itemHeight * CGFloat(numOfRows)
        pageHeight += totalItemHeight

        let calendarPageHeaderHeight = scrollStrategy == .scroll ? itemHeight : 0
        pageHeight += calendarPageHeaderHeight

        cachedPageHeight[index] = pageHeight
        return pageHeight
    }

    func calculateLeadingSpace(numOfLeadingItems: Int) -> CGFloat {
        let numOfLeadingItems = CGFloat(numOfLeadingItems)
        guard numOfLeadingItems >= 2 else {
            return numOfLeadingItems * itemWidth
        }
        let totalPadding = hPadding * (numOfLeadingItems - 1)
        let totalItemWidth = itemWidth * numOfLeadingItems

        return totalItemWidth + totalPadding
    }

    // MARK: Private

    @ObservationIgnored private lazy var cachedPageHeight: [Int: CGFloat] = [:]

    private func calculateItemWidth(maxWidth: CGFloat) -> CGFloat {
        let totalPaddingWidth = hPadding * (calendarMode.numOfCols - 1)
        let availableWidth = maxWidth - totalPaddingWidth
        return availableWidth / calendarMode.numOfCols
    }
}
