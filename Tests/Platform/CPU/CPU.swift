import Testing
import Platform

@Test("CPU.count")
func cpuCount() async throws {
    #expect(CPU.count > 0)
    #expect(CPU.count < 256)
}

@Test("CPU.totalCount")
func cpuTotalCount() async throws {
    #expect(CPU.totalCount > 0)
    #expect(CPU.totalCount < 256)
}
