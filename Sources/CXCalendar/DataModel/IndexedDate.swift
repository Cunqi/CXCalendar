//
//  IndexedDate.swift
//  CXCalendar
//
//  Created by Cunqi Xiao on 7/21/25.
//

import Foundation

/// This struct represents a date with an associated index.
/// It conforms to `Identifiable` protocol, allowing it to be used in
/// SwiftUI lists and other views that require unique identifiers.
///
/// This will significantly improve the performance of the calendar view since the
/// `id` will help SwiftUI to manage the views more efficiently.
struct IndexedDate: Identifiable {
    let value: Date
    let id: Int
}
