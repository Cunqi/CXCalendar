///
///  CalendarNavigatableHeader.swift
///  CXCalendar
///
///  Created by Cunqi Xiao on 8/16/25.
///
import CXUICore
import SwiftUI

struct CalendarNavigatableHeader: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(CXCalendarCoordinator.self) var coordinator: CXCalendarCoordinator

    let date: Date

    var body: some View {
        HStack(spacing: CXSpacing.halfX) {
            Text(date, format: .dateTime.month())
                .font(.body)
                .bold()
                .foregroundColor(.primary)

            Text(date, format: .dateTime.year())
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()

            Button {
                moveToPreviousMonth()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.body)
                    .padding(CXSpacing.halfX)
            }

            Button {
                moveToNextMonth()
            } label: {
                Image(systemName: "chevron.right")
                    .font(.body)
                    .padding(CXSpacing.halfX)
            }
        }
        .padding(CXSpacing.oneX)
    }

    // MARK: Private

    private func moveToPreviousMonth() {
        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: date) {
            withAnimation {
                coordinator.scroll(to: previousMonth)
            }
        }
    }

    private func moveToNextMonth() {
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: date) {
            withAnimation {
                coordinator.scroll(to: nextMonth)
            }
        }
    }
}
