@inlinable
internal func to<T>(_: T.Type) -> (Any) -> T? {
    { $0 as? T }
}

extension Optional {
    @inlinable
    mutating func setIfPresent(_ mod: (inout Wrapped) -> Void) {
        if var value = self {
            mod(&value)
            self = value
        }
    }
}
