import Test
import Platform

// TODO: test using MainActor
test.case("IsMainThread") {
    expect(Thread.isMain == false)
}

test.run()
