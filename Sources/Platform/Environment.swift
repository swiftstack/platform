public var Environment = Environ()

@dynamicMemberLookup
public struct Environ {
    public subscript(dynamicMember key: String) -> String? {
        get { return self[key] }
        nonmutating set { self[key] = newValue }
    }

    public subscript(key: String) -> String?  {
        get {
            return getValue(forKey: key)
        }
        nonmutating set {
            switch newValue {
            case .none: try? unsetValue(forKey: key)
            case .some(let value): try? setValue(value, forKey: key)
            }
        }
    }

    public func getValue(forKey key: String) -> String? {
        guard let pointer = getenv(key) else {
            return nil
        }
        return String(cString: pointer)
    }

    public func setValue(
        _ value: String,
        forKey key: String,
        replace: Bool = true) throws
    {
        guard setenv(key, value, replace ? 1 : 0) != -1 else {
            throw SystemError()
        }
    }

    public func unsetValue(forKey key: String) throws {
        guard unsetenv(key) != -1 else {
            throw SystemError()
        }
    }

    public lazy var values: [String : String] = {
        var values: [String: String] = [:]

        var pointer = environ
        while let next = pointer.pointee {
            defer { pointer += 1 }

            guard let string = String(validatingUTF8: next) else {
                continue
            }

            guard var index = string.firstIndex(of: "=") else {
                continue
            }

            let key = String(string[..<index])
            index = string.index(after: index)
            let value = String(string[index...])
            values[key] = value
        }

        return values
    }()
}
