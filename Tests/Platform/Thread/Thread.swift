import Testing
import Platform

@Test("Thread.isMain")
func isMainThread() async throws {
    await { @MainActor in
        #expect(Thread.isMain == true)
    }()
}
