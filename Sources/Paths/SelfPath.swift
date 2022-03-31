public struct SelfPath<Value>: Path {
    public typealias Root = Value

    public init() {}

    public func get(from root: Value) -> Value {
        root
    }

    public func set(_ value: Value, in root: inout Value) {
        root = value
    }
}

extension Path {
    static func `self`<Value>(_ valueType: Value.Type = Value.self) -> SelfPath<Value>
    where Self == SelfPath<Value> {
        .init()
    }
}
