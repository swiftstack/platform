import Test
import Platform

class EnvironmentTests: TestCase {
    func testEnvironment() {
        expect(Environment["testEnvironment"] == nil)
        Environment["testEnvironment"] = "test"
        expect(Environment["testEnvironment"] == "test")
    }

    func testDynamicMemberLookup() {
        expect(Environment.testDynamicMemberLookup == nil)
        Environment.testDynamicMemberLookup = "test"
        expect(Environment.testDynamicMemberLookup == "test")
    }

    func testValues() {
        expect(Environment.values.count > 0)
        expect(Environment.values[#function] == nil)
        Environment[#function] = "value"
        expect(Environment.values[#function] == "value")
    }

    func testEnvironmentValuesWithEqualSignInTheValue() {
        expect(Environment[#function] == nil)
        Environment[#function] = "test=test"
        expect(Environment.values[#function] == "test=test")
    }
}
