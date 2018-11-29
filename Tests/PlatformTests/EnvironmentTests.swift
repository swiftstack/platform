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
        assertNil(Environment.values[#function])
        Environment[#function] = "value"
        assertEqual(Environment.values[#function], "value")
    }

    func testEnvironmentValuesWithEqualSignInTheValue() {
        assertNil(Environment[#function])
        Environment[#function] = "test=test"
        assertEqual(Environment.values[#function], "test=test")
    }
}
