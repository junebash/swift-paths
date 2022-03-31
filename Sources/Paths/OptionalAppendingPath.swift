public struct OptionalAppendingPath<First, Second>: PartialPath
where First: PartialPath, Second: PartialPath {
    public typealias Root = First.Root

    public let first: First
    public let second: Second

    public func getOpaqueValue(from root: First.Root) -> Any? {
        first
            .getOpaqueValue(from: root)
            .flatMap(to(Second.Root.self))
            .flatMap(second.getOpaqueValue(from:))
    }
}

extension OptionalAppendingPath: ReadablePath
where First: ReadablePath, Second: ReadablePath, First.ReadableValue == Second.Root? {
    public typealias ReadableValue = Second.ReadableValue?

    public func get(from root: First.Root) -> Second.ReadableValue? {
        first
            .get(from: root)
            .map(second.get(from:))
    }
}

extension OptionalAppendingPath: WritablePath
where First: Path, Second: Path, First.Value == Second.Root? {
    public func set(_ secondValue: Second.Value?, in root: inout First.Root) {
        guard
            let secondValue = secondValue,
            var firstValue = first.get(from: root)
        else { return }

        second.set(secondValue, in: &firstValue)
        first.set(firstValue, in: &root)
    }
}

extension ReadablePath {
    public func compactMap<Other: ReadablePath>(_ other: Other) -> OptionalAppendingPath<Self, Other>
    where ReadableValue == Other.Root? {
        .init(first: self, second: other)
    }

    public func compactFlatMap<Other: ReadablePath, Wrapped>(_ other: Other) -> FlattenOptionalPath<OptionalAppendingPath<Self, Other>, Wrapped>
    where ReadableValue == Other.Root?, Other.ReadableValue == Wrapped? {
        FlattenOptionalPath(upstream: OptionalAppendingPath(first: self, second: other))
    }
}

struct Testtt {
    var someText: String?
}

//let noteuh =
let y = (\Testtt.someText).compactFlatMap(\String.first)
