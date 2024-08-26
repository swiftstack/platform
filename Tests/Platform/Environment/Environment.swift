import Testing
import Platform

@Suite(.serialized)
struct EnvironmentSuite {
    @Test("Environment")
    func environment() async throws {
        #expect(Environment["test"] == nil)
        Environment["test"] = "value"
        #expect(Environment["test"] == "value")
    }

    @Test("@dynamicMemberLookup")
    func dynamicMemberLookup() async throws {
        Environment["test"] = "value"
        #expect(Environment.test == "value")
        Environment.test = "dynamic lookup value"
        #expect(Environment.test == "dynamic lookup value")
    }

    @Test("Environment.values")
    func values() async throws {
        #expect(Environment.values.count > 0)
        Environment["test"] = "value"
        #expect(Environment.values["test"] == "value")
    }

    @Test("Environment.values with '=' sign in the value")
    func environmentValuesWithEqualSignInTheValue() async throws {
        Environment["test"] = "value"
        #expect(Environment["test"] == "value")
        Environment["test"] = "test=test"
        #expect(Environment.values["test"] == "test=test")
    }
}
