public struct SomeReadablePath<Upstream: ReadablePath>: ReadablePath {
    public typealias Root = Upstream.Root

    public let upstream: Upstream

    public func get(from root: Upstream.Root) -> Upstream.ReadableValue? {
        upstream.get(from: root)
    }
}

extension SomeReadablePath: WritablePath, FailablePath where Upstream: Path {
    public typealias WritableValue = Upstream.WritableValue

    public func set(_ value: WritableValue, in root: inout Upstream.Root) {
        upstream.set(value, in: &root)
    }
}

extension SomeReadablePath: Equatable where Upstream: Equatable {}
extension SomeReadablePath: Sendable where Upstream: Sendable {}

extension ReadablePath {
    public func someReadable() -> SomeReadablePath<Self> {
        .init(upstream: self)
    }
}
