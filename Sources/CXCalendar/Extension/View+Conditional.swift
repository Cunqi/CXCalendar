//
//  View+Extension.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func ifElse(
        _ condition: Bool,
        `if` ifTransform: (Self) -> some View,
        `else` elseTransform: (Self) -> some View
    ) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
}
