public struct AnyOptionalPath<Root, Value>: OptionalPath {
    @usableFromInline
    internal let _embed: (Value, inout Root) -> Void
    @usableFromInline
    internal let _extract: (Root) -> Value?

    @inlinable
    public init(
        embed: @escaping (Value, inout Root) -> Void,
        extract: @escaping (Root) -> Value?
    ) {
        self._embed = embed
        self._extract = extract
    }

    @inlinable
    public func embed(_ value: Value, in root: inout Root) {
        _embed(value, &root)
    }

    @inlinable
    public func extract(from root: Root) -> Value? {
        _extract(root)
    }
}

extension OptionalPath {
    @inlinable
    public static func path<Root, Value>(
        embed: @escaping (Value, inout Root) -> Void,
        extract: @escaping (Root) -> Value?
    ) -> AnyOptionalPath<Root, Value> where Self == AnyOptionalPath<Root, Value> {
        .init(embed: embed, extract: extract)
    }
}
