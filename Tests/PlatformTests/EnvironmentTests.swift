import Test
import Platform

class EnvironmentTests: TestCase {
    func testEnvironment() {
        assertNil(Environment["testEnvironment"])
        Environment["testEnvironment"] = "test"
        assertEqual(Environment["testEnvironment"], "test")
    }

    func testDynamicMemberLookup() {
        assertNil(Environment.testDynamicMemberLookup)
        Environment.testDynamicMemberLookup = "test"
        assertEqual(Environment.testDynamicMemberLookup, "test")
    }

    func testValues() {
        assertTrue(Environment.values.count > 0)
    }
}
