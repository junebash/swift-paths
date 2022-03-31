public protocol PartialPath {
    associatedtype Root

    func getOpaqueValue(from root: Root) -> Any?
}


public protocol ReadablePath: PartialPath {
    associatedtype ReadableValue

    func get(from root: Root) -> ReadableValue
}

extension ReadablePath {
    public func getOpaqueValue(from root: Root) -> Any? {
        get(from: root)
    }
}


public protocol WritablePath: PartialPath {
    associatedtype WritableValue

    func set(_ value: WritableValue, in root: inout Root)
}

extension WritablePath {
    public func getPossibleValue(from root: Root) -> WritableValue? {
        getOpaqueValue(from: root) as? WritableValue
    }

    public func setting(_ value: WritableValue, in root: Root) -> Root {
        var root = root
        set(value, in: &root)
        return root
    }
}


public typealias ReadableWritablePath = ReadablePath & WritablePath


public protocol FailablePath: ReadableWritablePath where ReadableValue == WritableValue? {
    typealias Value = WritableValue
}


public protocol Path: ReadablePath, WritablePath {
    associatedtype Value where Value == ReadableValue, Value == WritableValue
}
