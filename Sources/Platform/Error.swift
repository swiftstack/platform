public struct SystemError: Error, Equatable {
    public let number: Int

    public init(number: Int = .init(errno)) {
        self.number = number
    }
}

extension SystemError: CustomStringConvertible {
    public var description: String { .init(cString: strerror(errno)) }
}
