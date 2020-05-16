import Test
import Platform

class ThreadSpecificTests: TestCase {
    final class TestObject {
        let name: String

        init(name: String) {
            self.name = name
        }
    }

    func testGetThreadSpecific() {
        let threadSpecific = ThreadSpecific<TestObject>()

        let object = threadSpecific.get { .init(name: "from constructor") }

        expect(object.name == "from constructor")
    }

    func testSetThreadSpecific() {
        let threadSpecific = ThreadSpecific<TestObject>()

        threadSpecific.set(.init(name: "from set"))
        let object = threadSpecific.get { .init(name: "from constructor") }

        expect(object.name == "from set")
    }
}
