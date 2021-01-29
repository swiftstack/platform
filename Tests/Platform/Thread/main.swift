import Test
import Platform

test.case("IsMainThread") {
    expect(Thread.isMain == true)
}

test.run()
