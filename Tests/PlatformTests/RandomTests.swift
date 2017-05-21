import Test
@testable import Platform

class RandomTests: XCTestCase {
    func testRandom() {
        let first = arc4random()
        let second = arc4random()
        assertNotEqual(first, second)
    }

    func testRandomUniform() {
        for _ in 0..<1_000 {
            assert(arc4random_uniform(12) >= 0)
            assert(arc4random_uniform(12) < 12)
        }
    }

    func testRandomBuffer() {
        var first = [UInt8](repeating: 0, count: 10)
        var second = [UInt8](repeating: 0, count: 10)
        arc4random_buf(&first, first.count)
        arc4random_buf(&second, second.count)
        assertNotEqual(first, second)
    }
}
