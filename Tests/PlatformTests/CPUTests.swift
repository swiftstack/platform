import Test
import Platform

class CPUTests: TestCase {
    func testCPUCount() {
        expect(CPU.count > 0)
        expect(CPU.count < 256)
    }

    func testCPUTotalCount() {
        expect(CPU.totalCount > 0)
        expect(CPU.totalCount < 256)
    }
}
