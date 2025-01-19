import SwiftUI

extension Binding {
    func map<NewValue>(
        get: @escaping (Value) -> NewValue,
        set: @escaping (NewValue) -> Value
    ) -> Binding<NewValue> {
        Binding<NewValue>(
            get: { get(self.wrappedValue) },
            set: { self.wrappedValue = set($0) }
        )
    }
}
