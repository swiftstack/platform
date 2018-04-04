import Test
@testable import Platform

class EnvironmentTests: TestCase {
    func testEnvironment() {
        assertNil(Environment["EnvironmentTests"])
        Environment["EnvironmentTests"] = "test"
        assertEqual(Environment["EnvironmentTests"], "test")
    }
}
