public struct Descriptor: RawRepresentable {
    public let rawValue: Int32

    public init?(rawValue: Int32) {
        guard rawValue >= 0 else {
            return nil
        }
        self.rawValue = rawValue
    }

    public var flags: Int32 {
        get { return fcntl(rawValue, F_GETFD, 0) }
        set { _ = fcntl(rawValue, F_SETFD, newValue) }
    }

    public var status: Int32 {
        get { return fcntl(rawValue, F_GETFL, 0) }
        set { _ = fcntl(rawValue, F_SETFL, newValue) }
    }
}
