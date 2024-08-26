import Testing
import Platform

final class TestObject {
    let name: String

    init(name: String) {
        self.name = name
    }
}

@Test("ThreadSpecific default value")
func getThreadSpecific() async throws {
    let threadSpecific = ThreadSpecific<TestObject>()

    let object = threadSpecific.get(defaultValue: .init(name: "default value"))

    #expect(object.name == "default value")
}

@Test("ThreadSpecific set value")
func setThreadSpecific() async throws {
    let threadSpecific = ThreadSpecific<TestObject>()

    threadSpecific.set(.init(name: "custom value"))
    let object = threadSpecific.get(defaultValue: .init(name: "default value"))

    #expect(object.name == "custom value")
}
