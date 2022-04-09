extension WritableKeyPath: OptionalPath {
    @inlinable
    public func embed(_ value: Value, in root: inout Root) {
        root[keyPath: self] = value
    }

    @inlinable
    public func extract(from root: Root) -> Value? {
        root[keyPath: self]
    }
}

extension OptionalPath {
    @inlinable
    public static func keyPath<Root, Value>(
        _ k: WritableKeyPath<Root, Value>
    ) -> WritableKeyPath<Root, Value> {
        k
    }
}
