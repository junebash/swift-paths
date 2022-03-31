public struct OptionalPath<Value>: ReadablePath, WritablePath {
    public typealias Root = Value?

    public init() {}
    
    public func get(from root: Value?) -> Value? {
        root
    }

    public func set(_ value: Value, in root: inout Value?) {
        root = value
    }
}


extension ReadablePath {
    public static func `optional`<Value>(_ valueType: Value.Type = Value.self) -> OptionalPath<Value>
    where Self == OptionalPath<Value> {
        .init()
    }
}


extension WritablePath {
    public static func `optional`<Value>(_ valueType: Value.Type = Value.self) -> OptionalPath<Value>
    where Self == OptionalPath<Value> {
        .init()
    }
}

