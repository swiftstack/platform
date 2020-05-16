public struct DynamicLoadError: Error, CustomStringConvertible {
    public var description = String(cString: dlerror())
}

public func resolve<T>(function name: String) throws -> T {
    guard let handle = dlopen(nil, RTLD_LAZY) else {
        throw DynamicLoadError()
    }
    defer { dlclose(handle) }

    guard let pointer = dlsym(handle, name) else {
        throw DynamicLoadError()
    }

    return unsafeBitCast(pointer, to: T.self)
}
