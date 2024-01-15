#if os(Linux)
let _SC_PHYS_PAGES = Int32(Glibc._SC_PHYS_PAGES)
let _SC_PAGESIZE = Int32(Glibc._SC_PAGESIZE)
#endif

public enum Memory {
    public static var size: Size = {
        return Page.size * Page.count
    }()

    public struct Size {
        var bytesCount: Int

        public init(bytesCount: Int) {
            precondition(bytesCount >= 0)
            self.bytesCount = bytesCount
        }
    }

    public struct Page {
        public static var count: Int = {
            return sysconf(_SC_PHYS_PAGES)
        }()

        public static var size: Size = {
            return .init(bytesCount: sysconf(_SC_PAGESIZE))
        }()
    }
}

extension Memory.Size {
    private static let bitsInByte = 8

    public var bits: Int {
        return bytesCount * Memory.Size.bitsInByte
    }

    public var bytes: Int {
        return bytesCount
    }

    public static var byte: Memory.Size {
        return .init(bytesCount: 1)
    }

    public static var zero: Memory.Size {
        return .init(bytesCount: 0)
    }
}

extension Memory.Size {
    private static let binaryBase = Memory.Size(bytesCount: 1024)

    /// 1 KiB = 1024 B
    public static var kibibyte: Memory.Size {
        return byte * binaryBase
    }

    /// 1 MiB = 1024 KiB
    public static var mebibyte: Memory.Size {
        return kibibyte * binaryBase
    }

    /// 1 GiB = 1024 MiB
    public static var gibibyte: Memory.Size {
        return mebibyte * binaryBase
    }

    /// 1 TiB = 1024 GiB
    public static var tebibyte: Memory.Size {
        return gibibyte * binaryBase
    }

    /// 1 PiB = 1024 TiB
    public static var pebibyte: Memory.Size {
        return tebibyte * binaryBase
    }
}

extension Memory.Size {
    private static let decimalBase = Memory.Size(bytesCount: 1000)

    /// 1 kB = 1000 B
    public static var kilobyte: Memory.Size {
        return byte * decimalBase
    }

    /// 1 MB = 1000 kB
    public static var megabyte: Memory.Size {
        return kilobyte * decimalBase
    }

    /// 1 GB = 1000 MB
    public static var gigabyte: Memory.Size {
        return megabyte * decimalBase
    }

    /// 1 TB = 1000 GB
    public static var terabyte: Memory.Size {
        return gigabyte * decimalBase
    }

    /// 1 PB = 1000 TB
    public static var petabyte: Memory.Size {
        return terabyte * decimalBase
    }
}

// MARK: String

extension String {
    public init(
        _ size: Memory.Size,
        units: Memory.Size.Representation = .auto
    ) {
        func adjuct(_ size: Memory.Size) -> Memory.Size.Representation {
            switch size {
            case .zero ..< .kibibyte: return .bytes
            case .kibibyte ..< .mebibyte: return .binary(.kibibytes)
            case .mebibyte ..< .gibibyte: return .binary(.mebibytes)
            case .gibibyte ..< .tebibyte: return .binary(.gibibytes)
            case .tebibyte ..< .pebibyte: return .binary(.tebibytes)
            default: return .binary(.pebibytes)
            }
        }

        func format(_ value: Double) -> String {
            let integer = Int(value)
            let remainder = value.truncatingRemainder(dividingBy: 1)
            let fract = Int((remainder * 100).rounded())
            switch fract {
            case 0: return String(integer)
            case 1..<10: return "\(integer).0\(fract)"
            case 10..<100: return "\(integer).\(fract)"
            default: fatalError("unreachable")
            }
        }

        let representation = units == .auto ? adjuct(size) : units
        guard representation != .bytes else {
            self = "\(size.bytesCount) \(representation.symbol)"
            return
        }
        let divider = Double(representation.divider.bytesCount)
        let value = Double(size.bytesCount) / divider
        self = "\(format(value)) \(representation.symbol)"
    }
}

extension Memory.Size {
    public enum Representation: Equatable {
        case auto
        case bytes
        case decimal(Decimal)
        case binary(Binary)

        var divider: Memory.Size {
            switch self {
            case .binary(let binary): return binary.divider
            case .decimal(let decimal): return decimal.divider
            default: fatalError("unreachable")
            }
        }

        var symbol: String {
            switch self {
            case .bytes: return "B"
            case .binary(let binary): return binary.rawValue
            case .decimal(let decimal): return decimal.rawValue
            default: fatalError("unreachable")
            }
        }

        public enum Decimal: String {
            case kilobytes = "kB"
            case megabytes = "MB"
            case gigabytes = "GB"
            case terabytes = "TB"
            case petabytes = "PB"

            var divider: Memory.Size {
                switch self {
                case .kilobytes: return .kilobyte
                case .megabytes: return .megabyte
                case .gigabytes: return .gigabyte
                case .terabytes: return .terabyte
                case .petabytes: return .petabyte
                }
            }
        }

        public enum Binary: String {
            case kibibytes = "KiB"
            case mebibytes = "MiB"
            case gibibytes = "GiB"
            case tebibytes = "TiB"
            case pebibytes = "PiB"

            var divider: Memory.Size {
                switch self {
                case .kibibytes: return .kibibyte
                case .mebibytes: return .mebibyte
                case .gibibytes: return .gibibyte
                case .tebibytes: return .tebibyte
                case .pebibytes: return .pebibyte
                }
            }
        }
    }
}

// MARK: Numeric

extension Memory.Size: Numeric {
    public var magnitude: Int.Magnitude {
        return bytesCount.magnitude
    }

    public init(integerLiteral value: Int.IntegerLiteralType) {
        bytesCount = Int(integerLiteral: value)
    }

    public static func + (lhs: Memory.Size, rhs: Memory.Size) -> Memory.Size {
        return .init(bytesCount: lhs.bytesCount + rhs.bytesCount)
    }

    public static func += (lhs: inout Memory.Size, rhs: Memory.Size) {
        lhs.bytesCount += rhs.bytesCount
    }

    public static func - (lhs: Memory.Size, rhs: Memory.Size) -> Memory.Size {
        return .init(bytesCount: lhs.bytesCount - rhs.bytesCount)
    }

    public static func -= (lhs: inout Memory.Size, rhs: Memory.Size) {
        lhs.bytesCount -= rhs.bytesCount
    }

    public static func * (lhs: Memory.Size, rhs: Memory.Size) -> Memory.Size {
        return .init(bytesCount: lhs.bytesCount * rhs.bytesCount)
    }

    public static func *= (lhs: inout Memory.Size, rhs: Memory.Size) {
        lhs.bytesCount *= rhs.bytesCount
    }

    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let value = Int(exactly: source) else {
            return nil
        }
        bytesCount = value
    }
}

extension Memory.Size {
    public static func + (lhs: Memory.Size, rhs: Int) -> Memory.Size {
        return .init(bytesCount: lhs.bytesCount + rhs)
    }

    public static func += (lhs: inout Memory.Size, rhs: Int) {
        lhs.bytesCount += rhs
    }

    public static func - (lhs: Memory.Size, rhs: Int) -> Memory.Size {
        return .init(bytesCount: lhs.bytesCount - rhs)
    }

    public static func -= (lhs: inout Memory.Size, rhs: Int) {
        lhs.bytesCount -= rhs
    }

    public static func * (lhs: Memory.Size, rhs: Int) -> Memory.Size {
        return .init(bytesCount: lhs.bytesCount * rhs)
    }

    public static func *= (lhs: inout Memory.Size, rhs: Int) {
        lhs.bytesCount *= rhs
    }
}

// MARK: Comparable

extension Memory.Size: Comparable {
    public static func < (lhs: Memory.Size, rhs: Memory.Size) -> Bool {
        return lhs.bytesCount < rhs.bytesCount
    }
}
