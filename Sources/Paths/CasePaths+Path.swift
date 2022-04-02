@_exported import CasePaths

extension CasePath: ReadablePath {
    public func get(from root: Root) -> Value? {
        self.extract(from: root)
    }
}

extension CasePath: WritablePath {
    public func set(_ value: Value, in root: inout Root) {
        root = self.embed(value)
    }
}

extension CasePath: FailablePath {}
