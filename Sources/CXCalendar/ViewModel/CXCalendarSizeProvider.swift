//
//  CXCalendarSizeController.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation
import Observation
import SwiftUI

// MARK: - CXCalendarSizeCoordinator

@MainActor
@Observable
public class CXCalendarSizeProvider {
    // MARK: Lifecycle

    init(
        calendarMode: CXCalendarMode,
        scrollStrategy: CXCalendarScrollStrategy,
        layoutStrategy: CXCalendarLayoutStrategy,
        hPadding: CGFloat,
        vPadding: CGFloat
    ) {
        self.calendarMode = calendarMode
        self.scrollStrategy = scrollStrategy
        self.layoutStrategy = layoutStrategy
        self.hPadding = hPadding
        self.vPadding = vPadding
    }

    // MARK: Internal

    let calendarMode: CXCalendarMode
    let scrollStrategy: CXCalendarScrollStrategy
    let layoutStrategy: CXCalendarLayoutStrategy
    let hPadding: CGFloat
    let vPadding: CGFloat

    var itemWidth = CGFloat.zero
    var itemHeight = CGFloat.zero
    var calendarHeight = CGFloat.zero

    func calculateHeightForFixedHeightItem(with dimension: Dimension) {
        itemWidth = calculateItemWidth(dimension.size.width)
        itemHeight = switch layoutStrategy {
        case .equalWidth, .flexHeight:
            itemWidth
        case .fixedHeight(let height):
            height
        }
        let totalPaddingHeight = vPadding * (calendarMode.numOfRows - 1)
        let totalItemHeight = itemHeight * calendarMode.numOfRows
        calendarHeight = totalItemHeight + totalPaddingHeight
    }

    func calculateHeightForFlexHeightItem(with proxy: GeometryProxy, usedHeight: CGFloat = .zero) {
        let availableHeight = proxy.size.height - usedHeight
        itemWidth = calculateItemWidth(proxy.size.width)
        let totalPaddingHeight = vPadding * (calendarMode.numOfRows - 1)
        let remainingHeight = availableHeight - totalPaddingHeight
        itemHeight = remainingHeight / calendarMode.numOfRows
        calendarHeight = availableHeight
    }

    func calculateHeightForScrollStrategy(with proxy: GeometryProxy) {
        itemWidth = calculateItemWidth(proxy.size.width)
        switch layoutStrategy {
        case .equalWidth, .flexHeight:
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

    private func calculateItemWidth(_ width: CGFloat) -> CGFloat {
        let totalPaddingWidth = hPadding * (calendarMode.numOfCols - 1)
        let availableWidth = width - totalPaddingWidth
        return availableWidth / calendarMode.numOfCols
    }
}
