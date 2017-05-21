public typealias Descriptor = Int32

extension Descriptor {
    public var flags: Int32 {
        get { return fcntl(self, F_GETFD, 0) }
        set { _ = fcntl(self, F_SETFD, newValue) }
    }

    public var status: Int32 {
        get { return fcntl(self, F_GETFL, 0) }
        set { _ = fcntl(self, F_SETFL, newValue) }
    }
}
