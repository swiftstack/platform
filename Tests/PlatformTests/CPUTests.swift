import Test
import Platform

class CPUTests: TestCase {
    func testCPUCount() {
        assertTrue(CPU.count > 0)
        assertTrue(CPU.count < 256)
    }

    func testCPUTotalCount() {
        assertTrue(CPU.totalCount > 0)
        assertTrue(CPU.totalCount < 256)
    }
}
