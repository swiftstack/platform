import Test
import Platform

test.case("IsMainThread") {
    expect(Thread.isMain == true)
}

await test.run()
