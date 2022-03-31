public struct OptionalPath<Value>: PartialPath {
    public init() {}

    public func getOpaqueValue(from root: Value?) -> Any? {
        root
    }
}


extension OptionalPath: ReadablePath {
    public func get(from root: Value?) -> Value? {
        root
    }
}


extension OptionalPath: WritablePath {
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
