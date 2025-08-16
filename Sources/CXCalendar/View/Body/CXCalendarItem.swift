//
//  CXCalendarItem.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 8/13/25.
//

import CXUICore
import SwiftUI

public struct CXCalendarItem: CXCalendarItemViewRepresentable {
    // MARK: Public

    @Environment(CXCalendarCoordinator.self) public var coordinator: CXCalendarCoordinator

    public let dateInterval: DateInterval
    public let date: CXIndexedDate

    public var body: some View {
        Text(date.value, format: .dateTime.day())
            .font(.body)
            .fontWeight(fontWeight)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                if isSelected, canSelect {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor.opacity(0.2))
                }
            }
            .contentShape(.circle)
            .onTapGesture {
                guard canSelect else {
                    return
                }
                withAnimation {
                    coordinator.select(date: date.value)
                }
            }
    }

    // MARK: Private

    private var canSelect: Bool {
        isInRange || core.scrollStrategy != .scroll
    }

    private var isSelected: Bool {
        coordinator.isDateSelected(date.value)
    }

    private var fontWeight: Font.Weight {
        isStartDate ? .bold : .regular
    }

    private var foregroundColor: Color {
        isInRange ? .primary : core.scrollStrategy == .page ? .secondary : .clear
    }
}
