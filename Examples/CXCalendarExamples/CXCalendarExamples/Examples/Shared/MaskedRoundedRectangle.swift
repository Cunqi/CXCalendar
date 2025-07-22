//
//  MaskedRoundedRectangle.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/21/25.
//

import CXUICore
import SwiftUI

struct MaskedRoundedRectangle: Shape {
    var cornerRadius: CGFloat = CXSpacing.oneX
    var corners = UIRectCorner.allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        return Path(path.cgPath)
    }
}
