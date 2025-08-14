//
//  ContentView.swift
//  CXCalendarExample-V2
//
//  Created by Cunqi Xiao on 8/13/25.
//

import SwiftUI
import CXCalendar

struct ContentView: View {
    var body: some View {
        VStack {
            CXCalendarView(context: .month(.page))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
