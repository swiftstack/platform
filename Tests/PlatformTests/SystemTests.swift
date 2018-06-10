import Test
import Platform

class SystemTests: TestCase {
    func testInt() {
        assertThrowsError(try system {
            return -1
        })
    }

    func testOpaquePointer() {
        assertThrowsError(try system {
            return nil as OpaquePointer?
        })
    }

    func testGenericPointer() {
        assertThrowsError(try system {
            return nil as UnsafeMutablePointer<Int>?
        })
    }
}
