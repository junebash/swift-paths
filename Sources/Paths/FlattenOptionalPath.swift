public struct FlattenOptionalPath<Upstream: ReadablePath, Wrapped>: ReadablePath
where Upstream.ReadableValue == Wrapped?? {
    public typealias Root = Upstream.Root

    public let upstream: Upstream

    public func get(from root: Upstream.Root) -> Wrapped? {
        upstream.get(from: root).flatMap { $0 }
    }
}

extension ReadablePath {
    public func flattened<Wrapped>() -> FlattenOptionalPath<Self, Wrapped>
    where ReadableValue == Wrapped?? {
        .init(upstream: self)
    }
}
