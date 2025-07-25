//
//  OnboardTodoCardView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/22/25.
//

import CXUICore
import Foundation
import SwiftUI

struct OnboardTodoCardView: View {
    let todo: Todo

    var body: some View {
        VStack(spacing: CXSpacing.oneAndHalfX) {
            Text(todo.title)
                .font(.subheadline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Text(todo.time, format: .dateTime.hour().minute())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text(todo.date.value, format: .dateTime.day().month(.wide))
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: CXSpacing.oneX)
                .fill(Color.accentColor.opacity(0.2))
        }
        .padding(.vertical, CXSpacing.halfX)
    }
}
