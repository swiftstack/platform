import Test
import Platform

final class TestObject {
    let name: String

    init(name: String) {
        self.name = name
    }
}

test.case("GetThreadSpecific") {
    let threadSpecific = ThreadSpecific<TestObject>()

    let object = threadSpecific.get { .init(name: "from constructor") }

    expect(object.name == "from constructor")
}

test.case("SetThreadSpecific") {
    let threadSpecific = ThreadSpecific<TestObject>()

    threadSpecific.set(.init(name: "from set"))
    let object = threadSpecific.get { .init(name: "from constructor") }

    expect(object.name == "from set")
}

test.run()
