#if os(Linux)
let _SC_NPROCESSORS_ONLN = Int32(Glibc._SC_NPROCESSORS_ONLN)
let _SC_NPROCESSORS_CONF = Int32(Glibc._SC_NPROCESSORS_CONF)
#endif

public enum CPU {
    /// CPUs count available for the process
    public static var count: Int {
        let result = sysconf(_SC_NPROCESSORS_ONLN)
        guard result != -1 else { return 0 }
        return result
    }

    /// CPUs count configured in the system
    public static var totalCount: Int {
        let result = sysconf(_SC_NPROCESSORS_CONF)
        guard result != -1 else { return 0 }
        return result
    }
}
