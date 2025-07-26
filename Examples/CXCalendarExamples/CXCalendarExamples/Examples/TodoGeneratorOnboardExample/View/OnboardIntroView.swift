//
//  OnboardIntroView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/21/25.
//

import SwiftUI

struct OnboardIntroView: View {
    @State private var viewModel = TodoGeneratorOnboardViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Todo Generator Onboard")
                    .font(.title)
                    .padding()
                Text("""
                    This is a demo app that will present various customizations of CXCalendar.
                    """)
                .padding()

                NavigationLink("Next") {
                    OnboardDateRangePickerView()
                }
            }
        }
    }
}
