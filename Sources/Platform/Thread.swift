#if os(Linux)
private func pthread_main_np() -> Int32 { CFIsMainThread() ? 1 : 0 }

private let CFIsMainThread: @convention(c) () -> Bool = {
    try! resolve(function: "_CFIsMainThread")
}()
#endif

public struct Thread {
    public static var isMain: Bool { pthread_main_np() != 0 }
}
