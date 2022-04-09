public protocol OptionalPath {
    associatedtype Root
    associatedtype Value

    func embed(_ value: Value, in root: inout Root)
    func extract(from root: Root) -> Value?
}

extension OptionalPath {
    public func embedding(_ value: Value, in root: Root) -> Root {
        var root = root
        self.embed(value, in: &root)
        return root
    }
}
