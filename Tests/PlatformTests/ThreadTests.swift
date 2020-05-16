import Test
import Platform

class ThreadTests: TestCase {
    func testIsMainThread() {
        expect(Thread.isMain == true)
    }
}
