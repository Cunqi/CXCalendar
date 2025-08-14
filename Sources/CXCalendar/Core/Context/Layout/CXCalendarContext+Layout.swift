//
//  CXCalendarCoordinator+Layout.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//
import SwiftUI

extension CXCalendarContext.Builder {
    public func axis(_ axis: Axis) -> CXCalendarContext.Builder {
        self.axis = axis
        return self
    }

    public func hPadding(_ hPadding: CGFloat) -> CXCalendarContext.Builder {
        self.hPadding = hPadding
        return self
    }

    public func vPadding(_ vPadding: CGFloat) -> CXCalendarContext.Builder {
        self.vPadding = vPadding
        return self
    }

    public func itemLayoutStrategy(_ itemLayoutStrategy: CXCalendarItemLayoutStrategry)
        -> CXCalendarContext.Builder {
        self.itemLayoutStrategy = itemLayoutStrategy
        return self
    }

    public func makeLayout() -> any CXCalendarLayoutProtocol {
        if scrollStrategy == .scroll || mode == .year {
            axis = .vertical
        }

        let columns = Array(repeating: GridItem(.flexible(), spacing: hPadding), count: 7)
        return CalendarLayout(
            axis: axis,
            hPadding: hPadding,
            vPadding: vPadding,
            columns: columns,
            itemLayoutStrategy: itemLayoutStrategy
        )
    }
}
