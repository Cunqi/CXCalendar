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

    func calculateHeightForPageStrategy(with proxy: GeometryProxy, titleHeight: CGFloat = .zero) {
        let maxHeight = proxy.size.height - titleHeight
        itemWidth = calculateItemWidth(with: proxy)

        let totalPaddingHeight = vPadding * (calendarMode.numOfRows - 1)
        let remainingHeight = maxHeight - totalPaddingHeight
        let maxItemHeight = remainingHeight / calendarMode.numOfRows

        let expectedItemHeight = switch layoutStrategy {
        case .square:
            itemWidth
        case .fixedHeight(let height):
            height
        case .flexHeight:
            maxHeight
        }

        itemHeight = min(expectedItemHeight, maxItemHeight)
        calendarHeight = itemHeight * calendarMode.numOfRows + totalPaddingHeight
    }

    func calculateHeightForScrollStrategy(with proxy: GeometryProxy) {
        itemWidth = calculateItemWidth(with: proxy)
        switch layoutStrategy {
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

    private func calculateItemWidth(with proxy: GeometryProxy) -> CGFloat {
        let maxWidth = proxy.size.width - proxy.safeAreaInsets.leading - proxy.safeAreaInsets
            .trailing
        let totalPaddingWidth = hPadding * (calendarMode.numOfCols - 1)
        let availableWidth = maxWidth - totalPaddingWidth
        return availableWidth / calendarMode.numOfCols
    }
}
