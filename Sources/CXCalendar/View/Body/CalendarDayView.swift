//
//  CalendarBodyContentItemView.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/13/25.
//

import CXUICore
import SwiftUI

/// This view represents a single day in the calendar, displaying the date and handling selection logic.
/// This is the default implementation of a day view in the calendar.
struct CalendarDayView: CXCalendarDayViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarManager.self) var manager

    let dateInterval: DateInterval
    let day: Date
    let namespace: Namespace.ID

    var isInRange: Bool {
        dateInterval.containsExceptEnd(day, calendar: calendar)
    }

    var isStartDate: Bool {
        calendar.isSameDay(startDate, day)
    }

    var isSelected: Bool {
        interaction.isSelected(day, manager.selectedDate, calendar)
    }

    var body: some View {
        if shouldHideWhenOutOfBounds, !isInRange {
            Color.clear
        } else {
            Text(day, format: .dateTime.day())
                .font(.footnote)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ifElse(manager.context.calendarType.scrollBehavior == .page) {
                    $0.aspectRatio(1, contentMode: .fit)
                } else: {
                    $0.frame(height: layout.rowHeight)
                }
                .background(
                    RoundedRectangle(cornerRadius: CXSpacing.halfX)
                        .fill(backgroundColor)
                )
                .overlay {
                    if isSelected {
                        RoundedRectangle(cornerRadius: CXSpacing.halfX)
                            .stroke(Color.primary, lineWidth: CXSpacing.quarterX)
                            .padding(1)
                            .ifElse(calendarType.isWeek) {
                                $0.matchedGeometryEffect(
                                    id: "selection",
                                    in: namespace,
                                    isSource: isSelected
                                )
                            } else: {
                                $0.transition(.scale(0.9).combined(with: .opacity))
                            }
                    }
                }
                .onTapGesture {
                    guard interaction.canSelect(dateInterval, day, calendar) else {
                        return
                    }
                    withAnimation(.interpolatingSpring) {
                        manager.selectedDate = day
                    }
                }
        }
    }

    // MARK: Private

    private var foregroundColor: Color {
        isInRange ? .primary : .secondary
    }

    private var backgroundColor: Color {
        if isStartDate {
            return .accentColor.opacity(0.5)
        }
        return isInRange ? Color.green.opacity(0.1) : Color.clear
    }

    private var shouldHideWhenOutOfBounds: Bool {
        context.calendarType.scrollBehavior == .scroll
    }
}
