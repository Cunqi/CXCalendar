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
        let template = CXCalendarTemplate.year()
            .builder
            .itemLayoutStrategy(.flexHeight)
            .build()
        VStack {
            CXCalendarView(template: template)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
