//
//  Calendar+Time.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/20/25.
//

import Foundation

extension Calendar {
    func time(of date: Date) -> Date {
        let components = dateComponents([.hour, .minute, .second], from: date)
        return self.date(from: components) ?? date
    }
}
