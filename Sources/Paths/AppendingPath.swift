public struct AppendingPath<First: OptionalPath, Second: OptionalPath>: OptionalPath
where First.Value == Second.Root {
    public let first: First
    public let second: Second

    @inlinable
    public init(first: First, second: Second) {
        self.first = first
        self.second = second
    }

    @inlinable
    public func embed(_ value: Second.Value, in root: inout First.Root) {
        guard var mid = first.extract(from: root) else { return }
        second.embed(value, in: &mid)
        first.embed(mid, in: &root)
    }

    @inlinable
    public func extract(from root: First.Root) -> Second.Value? {
        first.extract(from: root).flatMap(second.extract(from:))
    }
}

extension OptionalPath {
    @inlinable
    public func appending<Other: OptionalPath>(_ other: Other) -> AppendingPath<Self, Other> {
        .init(first: self, second: other)
    }
}
