import Foundation
import UIKit
public struct AnyPartialPath<Root>: PartialPath {
    let get: (Root) -> Any?

    public init(get: @escaping (Root) -> Any?) {
        self.get = get
    }

    public init<Wrapped: PartialPath>(_ wrapped: Wrapped) where Wrapped.Root == Root {
        self.get = wrapped.getOpaqueValue(from:)
    }

    public func getOpaqueValue(from root: Root) -> Any? {
        get(root)
    }
}


public struct AnyReadablePath<Root, ReadableValue>: ReadablePath {
    let get: (Root) -> ReadableValue

    public init(get: @escaping (Root) -> ReadableValue) {
        self.get = get
    }

    public init<Wrapped: ReadablePath>(_ wrapped: Wrapped)
    where Wrapped.Root == Root, Wrapped.ReadableValue == ReadableValue {
        self.get = wrapped.get(from:)
    }

    public func get(from root: Root) -> ReadableValue {
        get(root)
    }
}


public struct AnyWritablePath<Root, WritableValue>: WritablePath {
    let set: (WritableValue, inout Root) -> Void

    public init(set: @escaping (WritableValue, inout Root) -> Void) {
        self.set = set
    }

    public init<Wrapped: WritablePath>(_ wrapped: Wrapped)
    where Wrapped.Root == Root, Wrapped.WritableValue == WritableValue {
        self.set = wrapped.set(_:in:)
    }

    public func set(_ value: WritableValue, in root: inout Root) {
        set(value, &root)
    }

    public func getOpaqueValue(from root: Root) -> Any? {
        nil
    }
}


public struct AnyReadableWritablePath<Root, ReadableValue, WritableValue>: ReadablePath, WritablePath {
    let get: (Root) -> ReadableValue
    let set: (WritableValue, inout Root) -> Void

    public init(
        get: @escaping (Root) -> ReadableValue,
        set: @escaping (WritableValue, inout Root) -> Void
    ) {
        self.get = get
        self.set = set
    }

    public init<Wrapped: ReadablePath & WritablePath>(_ wrapped: Wrapped)
    where Wrapped.Root == Root, Wrapped.ReadableValue == ReadableValue, Wrapped.WritableValue == WritableValue {
        self.get = wrapped.get(from:)
        self.set = wrapped.set(_:in:)
    }

    public func get(from root: Root) -> ReadableValue {
        get(root)
    }

    public func set(_ value: WritableValue, in root: inout Root) {
        set(value, &root)
    }
}

public typealias AnyOptionalPath<Root, Value> = AnyReadableWritablePath<Root, Value?, Value>
public typealias AnyPath<Root, Value> = AnyReadableWritablePath<Root, Value, Value>
