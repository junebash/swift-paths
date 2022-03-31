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
    func getPossibleValue(from root: Root) -> WritableValue? {
        getOpaqueValue(from: root) as? WritableValue
    }
}


public protocol Path: ReadablePath, WritablePath {
    associatedtype Value where Value == ReadableValue, Value == WritableValue
}
