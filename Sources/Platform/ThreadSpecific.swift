public class ThreadSpecific<T: AnyObject> {
    @usableFromInline
    var key: pthread_key_t

    public init() {
        key = pthread_key_t()
        pthread_key_create(&key, { pointer in
            #if os(Linux)
            Unmanaged<AnyObject>.fromOpaque(pointer!).release()
            #else
            Unmanaged<AnyObject>.fromOpaque(pointer).release()
            #endif
        })
    }

    @inlinable
    public func get(defaultValue: @autoclosure () -> T) -> T {
        if let specific = pthread_getspecific(key) {
            return Unmanaged<T>.fromOpaque(specific).takeUnretainedValue()
        } else {
            let value = defaultValue()
            set(value)
            return value
        }
    }

    @inlinable
    public func set(_ value: T) {
        pthread_setspecific(key, Unmanaged.passRetained(value).toOpaque())
    }
}
