@inline(__always)
@discardableResult
public func system<T: SignedNumeric>(_ task: () -> T) throws -> T {
    let result = task()
    guard result != -1 else {
        throw SystemError()
    }
    return result
}

@inline(__always)
public func system<T>(
    _ task: () -> UnsafeMutablePointer<T>?
) throws -> UnsafeMutablePointer<T> {
    guard let result = task() else {
        throw SystemError()
    }
    return result
}

@inline(__always)
public func system(
    _ task: () -> OpaquePointer?
) throws -> OpaquePointer {
    guard let result = task() else {
        throw SystemError()
    }
    return result
}
