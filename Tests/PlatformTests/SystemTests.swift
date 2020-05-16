import Test
import Platform

class SystemTests: TestCase {
    func testInt() {
        expect(throws: SystemError()) {
            try system { -1 }
        }
    }

    func testOpaquePointer() {
        expect(throws: SystemError()) {
            try system { nil as OpaquePointer? }
        }
    }

    func testGenericPointer() {
        expect(throws: SystemError()) {
            try system { nil as UnsafeMutablePointer<Int>? }
        }
    }
}
