public struct SelfPath<Value>: OptionalPath {
    public typealias Root = Value

    @inlinable
    public init() {}

    @inlinable
    public func embed(_ value: Value, in root: inout Value) {
        root = value
    }

    @inlinable
    public func extract(from root: Value) -> Value? {
        root
    }
}

extension SelfPath: Equatable, Sendable {}

extension OptionalPath {
    @inlinable
    public static func `self`<Value>(_ valueType: Value.Type = Value.self) -> SelfPath<Value>
    where Self == SelfPath<Value> {
        .init()
    }
}
