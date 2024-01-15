import Test
import Platform

test("IsMainThread") {
    expect(Thread.isMain == true)
}

await run()
