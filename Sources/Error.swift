public struct SystemError: Error, CustomStringConvertible {
    public init(){}
    private let message = String(cString: strerror(errno))
    public let number = errno
    public var description: String {
        return "\(number): \(message)"
    }
}
