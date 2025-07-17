//
//  View+Extension.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/16/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func ifElse<IfContent: View, ElseContent: View>(_ condition: Bool,
                                                    `if` ifTransform: (Self) -> IfContent,
                                                    `else` elseTransform: (Self) -> ElseContent) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
}

