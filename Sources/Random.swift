#if os(Linux)
    var cache = [UInt32]()
    let capacity = 128

    public func arc4random() -> UInt32 {
        if let next = cache.popLast() {
            return next
        }
        updateCache()
        return arc4random()
    }

    public func arc4random_uniform(_ upperBound: UInt32) -> UInt32 {
        return arc4random() % upperBound
    }

    public func arc4random_buf(_ buffer: UnsafeMutableRawPointer, _ count: Int) {
        let descriptor = open("/dev/urandom", O_RDONLY)
        precondition(descriptor >= 1, "/dev/urandom is unavailable")
        let result = read(descriptor, buffer, count)
        close(descriptor)
        precondition(result == count, "read less than expected")
    }

    fileprivate func updateCache() {
        cache = [UInt32](repeating: 0, count: capacity)
        arc4random_buf(&cache, MemoryLayout<UInt32>.size * capacity)
        precondition(cache.count > 0, "can't init random")
    }
#endif
