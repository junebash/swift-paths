@_exported import CasePaths

extension CasePath: OptionalPath {
    @inlinable
    public func embed(_ value: Value, in root: inout Root) {
        root = self.embed(value)
    }
}
