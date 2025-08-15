//
//  DateDisplayCardView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/21/25.
//

import CXUICore
import SwiftUI

struct DateDisplayCardView: View {
    let label: String
    let date: Date?

    var body: some View {
        VStack(alignment: .leading, spacing: CXSpacing.halfX) {
            Text(label)
                .font(.caption)

            if let date {
                Text(date, format: .dateTime.day().month(.wide))
                    .font(.body)
                    .foregroundColor(.primary)
                Text(date, format: .dateTime.year())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("--")
                    .font(.body)
                Text("--")
                    .font(.body)
                    .foregroundColor(.clear)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: CXCornerRadius.medium)
                .fill(Color.secondary.opacity(0.1))
        )
    }
}

#Preview {
    HStack {
        DateDisplayCardView(label: "From", date: .now)
        DateDisplayCardView(label: "To", date: nil)
    }
}
