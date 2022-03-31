extension PartialKeyPath: PartialPath {
    public func getOpaqueValue(from root: Root) -> Any? {
        root[keyPath: self]
    }
}

extension KeyPath: ReadablePath {
    public func get(from root: Root) -> Value {
        root[keyPath: self]
    }
}

extension WritableKeyPath: Path {
    public func set(_ value: Value, in root: inout Root) {
        root[keyPath: self] = value
    }
}
