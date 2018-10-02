public enum Signal: RawRepresentable {
    case hangup
    case interrupt
    case quit
    /// not reset when caught
    case illegalInstruction
    /// not reset when caught
    case traceTrap
    case abort
    case user1
    case user2
    case unknown(Int)

    public init?(rawValue: Int) {
        switch rawValue {
        case Int(SIGHUP): self = .hangup
        case Int(SIGINT): self = .interrupt
        case Int(SIGQUIT): self = .quit
        case Int(SIGILL): self = .illegalInstruction
        case Int(SIGTRAP): self = .traceTrap
        case Int(SIGABRT): self = .abort
        case Int(SIGUSR1): self = .user1
        case Int(SIGUSR2): self = .user2
        case _ where rawValue <= Int32.max: self = .unknown(rawValue)
        default: return nil
        }
    }

    public var rawValue: Int {
        switch self {
        case .hangup: return Int(SIGHUP)
        case .interrupt: return Int(SIGINT)
        case .quit: return Int(SIGQUIT)
        case .illegalInstruction: return Int(SIGILL)
        case .traceTrap: return Int(SIGTRAP)
        case .abort: return Int(SIGABRT)
        case .user1: return Int(SIGUSR1)
        case .user2: return Int(SIGUSR2)
        case .unknown(let signal): return signal
        }
    }
}

extension Signal {
    public typealias Handler = @convention(c) (Int) -> Void

    public static func trap(_ signal: Signal, to handler: @escaping Handler) {
        var action = sigaction(handler)
        sigaction(Int32(signal.rawValue), &action, nil)
    }

    public static func trap(
        _ signals: Signal...,
        to handler: @escaping Handler)
    {
        signals.forEach { trap($0, to: handler) }
    }

    public static func raise(_ signal: Signal) {
        Platform.raise(Int32(signal.rawValue))
    }

    public static func ingore(_ signal: Signal) {
        Platform.signal(Int32(signal.rawValue), SIG_IGN)
    }

    public static func restore(_ signal: Signal) {
        Platform.signal(Int32(signal.rawValue), SIG_DFL)
    }
}

extension sigaction {
    init(_ action: @escaping Signal.Handler) {
        self.init()
        #if os(macOS)
        typealias handlerType = Platform.__sigaction_u
        self.__sigaction_u = unsafeBitCast(action, to: handlerType.self)
        #elseif os(Linux)
        typealias handlerType = __Unnamed_union___sigaction_handler
        self.__sigaction_handler = unsafeBitCast(action, to: handlerType.self)
        #endif
    }
}
