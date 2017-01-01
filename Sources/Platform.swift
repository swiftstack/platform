#if os(Linux)
    @_exported import Glibc
#else
    @_exported import Darwin.C
#endif

#if os(Linux)
    public let SOCK_STREAM = Int32(Glibc.SOCK_STREAM.rawValue)
#endif
