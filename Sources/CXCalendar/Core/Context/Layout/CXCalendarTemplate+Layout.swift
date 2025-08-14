//
//  CXCalendarTemplate+Layout.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//
import SwiftUI

extension CXCalendarTemplate.Builder {
    // MARK: Public

    public func axis(_ axis: Axis) -> CXCalendarTemplate.Builder {
        self.axis = axis
        return self
    }

    public func hPadding(_ hPadding: CGFloat) -> CXCalendarTemplate.Builder {
        self.hPadding = hPadding
        return self
    }

    public func vPadding(_ vPadding: CGFloat) -> CXCalendarTemplate.Builder {
        self.vPadding = vPadding
        return self
    }

    public func itemLayoutStrategy(_ itemLayoutStrategy: CXCalendarItemLayoutStrategry)
        -> CXCalendarTemplate.Builder {
        self.itemLayoutStrategy = itemLayoutStrategy
        return self
    }

    // MARK: Internal

    func makeLayout() -> any CXCalendarLayoutProtocol {
        if scrollStrategy == .scroll {
            axis = .vertical
        }

        if mode == .year {
            axis = .vertical
            itemLayoutStrategy = .flexHeight
        }

        let columns = Array(
            repeating: GridItem(.flexible(), spacing: hPadding),
            count: Int(mode.numOfCols)
        )
        return CalendarLayout(
            axis: axis,
            hPadding: hPadding,
            vPadding: vPadding,
            columns: columns,
            itemLayoutStrategy: itemLayoutStrategy
        )
    }
}
