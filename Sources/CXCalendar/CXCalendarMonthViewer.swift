import SwiftUI

public struct CXCalendarMonthViewer: CXCalendarViewRepresentable {
    // MARK: Lifecycle

    public init(
        startDate: Date = .now,
        selectedDate: Binding<Date> = .constant(.now),
        selectFirstDayByDefault: Bool = false
    ) {
        let template = CXCalendarTemplate.month(.page)
            .builder
            .startDate(startDate)
            .selectedDate(selectedDate.wrappedValue)
            .layoutStrategy(.equalWidth)
            .hPadding(.zero)
            .vPadding(.zero)
            .calendarHeader {
                CalendarNavigatableHeader(date: $0)
            }
            .build()

        _coordinator = State(initialValue: CXCalendarCoordinator(template: template))
        _selectedDate = selectedDate
        self.selectFirstDayByDefault = selectFirstDayByDefault
    }

    // MARK: Public

    @State public var coordinator: CXCalendarCoordinator

    public var body: some View {
        PageCalendarContainer(coordinator: $coordinator)
            .onAppear {
                coordinator.scrollEnabled = false
            }
            .onChange(of: coordinator.anchorDate) { _, _ in
                if selectFirstDayByDefault {
                    coordinator.selectFirstDateAfterAnchorDateChange()
                }
            }
            .onChange(of: coordinator.selectedDate) { _, newValue in
                selectedDate = newValue
            }
    }

    // MARK: Internal

    @Binding var selectedDate: Date

    let selectFirstDayByDefault: Bool
}
