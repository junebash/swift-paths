public struct AppendingPath<First: PartialPath, Second: PartialPath>: PartialPath {
    public typealias Root = First.Root

    public let first: First
    public let second: Second

    init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }

    public func getOpaqueValue(from root: First.Root) -> Any? {
        guard let secondRoot = first.getOpaqueValue(from: root) as? Second.Root
        else { return nil }
        return second.getOpaqueValue(from: secondRoot)
    }
}

extension AppendingPath: ReadablePath
where First: ReadablePath, Second: ReadablePath, First.ReadableValue == Second.Root {
    public func get(from root: First.Root) -> Second.ReadableValue {
        second.get(from: first.get(from: root))
    }
}

extension AppendingPath: WritablePath
where First: Path, Second: WritablePath, First.Value == Second.Root {
    public func set(_ value: Second.WritableValue, in root: inout First.Root) {
        var secondRoot = first.get(from: root)
        second.set(value, in: &secondRoot)
        first.set(secondRoot, in: &root)
    }
}

extension AppendingPath: Path
where First: Path, Second: Path, First.Value == Second.Root {}


extension ReadablePath {
    public func map<Other: PartialPath>(_ other: Other) -> AppendingPath<Self, Other> {
        .init(self, other)
    }
}

struct Temp {
    var optionalText: String?
}

let x = \Temp.optionalText

