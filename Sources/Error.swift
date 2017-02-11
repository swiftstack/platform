public struct SystemError: Error, CustomStringConvertible {
    public init(){}
    public let number = errno
    public let description = String(cString: strerror(errno))
}
