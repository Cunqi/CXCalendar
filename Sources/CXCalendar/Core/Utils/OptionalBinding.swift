import SwiftUI

@propertyWrapper
struct OptionalBinding<Value>: DynamicProperty where Value: Equatable {
    // MARK: Lifecycle

    init(_ defaultValue: Value, _ binding: Binding<Value>? = nil) {
        _storedValue = State(initialValue: defaultValue)
        self.binding = binding
    }

    // MARK: Internal

    var wrappedValue: Value {
        get {
            binding?.wrappedValue ?? storedValue
        }
        nonmutating set {
            if let binding, binding.wrappedValue != newValue {
                binding.wrappedValue = newValue
            }
        }
    }

    var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    // MARK: Private

    @State private var storedValue: Value

    private var binding: Binding<Value>?
}
