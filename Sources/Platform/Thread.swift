#if os(Linux)
private func pthread_main_np() -> Int32 { syscall(186) == getpid() ? 1 : 0 }

private let syscall: @convention(c) (Int) -> Int = {
    try! resolve(function: "syscall")
}()
#endif

public struct Thread {
    public static var isMain: Bool { pthread_main_np() != 0 }
}
