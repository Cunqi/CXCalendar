//
//  CXCalendarTemplate+Interaction.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import Foundation

extension CXCalendarTemplate.Builder {
    public func onCalendarItemSelect(_ onCalendarItemSelect: OnCalendarItemSelect?)
        -> CXCalendarTemplate.Builder {
        self.onCalendarItemSelect = onCalendarItemSelect
        return self
    }

    public func onAnchorDateChange(_ onAnchorDateChange: OnAnchorDateChange?) -> CXCalendarTemplate
        .Builder {
        self.onAnchorDateChange = onAnchorDateChange
        return self
    }

    func makeInteraction() -> any CXCalendarInteractionProtocol {
        CalendarInteraction(
            onCalendarItemSelect: onCalendarItemSelect,
            onAnchorDateChange: onAnchorDateChange
        )
    }
}
