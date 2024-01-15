import Test
import Platform

test("CPUCount") {
    expect(CPU.count > 0)
    expect(CPU.count < 256)
}

test("CPUTotalCount") {
    expect(CPU.totalCount > 0)
    expect(CPU.totalCount < 256)
}

await run()
