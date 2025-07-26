//
//  OnboardDailyTodoAccessoryView.swift
//  CXCalendarExamples
//
//  Created by Cunqi Xiao on 7/22/25.
//

import CXCalendar
import CXUICore
import Foundation
import SwiftUI

struct OnboardDailyTodoAccessoryView: CXCalendarViewRepresentable {
    // MARK: Internal

    @Environment(TodoGeneratorOnboardViewModel.self) var viewModel
    @Environment(CXCalendarManager.self) var manager

    let date: Date

    var todoList: DailyTodoList? {
        viewModel.fetchDailyTodoList(for: date, calendar: calendar)
    }

    var body: some View {
        VStack {
            if let todoList {
                makeTodoListView(for: todoList)
            } else {
                Text("Empty Todo List")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(CXSpacing.halfX)
        .background {
            RoundedRectangle(cornerRadius: CXSpacing.halfX)
                .fill(.secondary.opacity(0.1))
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                viewModel.detailDate = date
            } label: {
                Text("See detail")
                    .foregroundStyle(.primary)
                    .padding()
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
        }
    }

    // MARK: Private

    private func makeTodoListView(for todoList: DailyTodoList) -> some View {
        List(todoList.todos) { todo in
            OnboardTodoCardView(todo: todo)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
