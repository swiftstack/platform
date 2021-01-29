import Test
import Platform

test.case("CPUCount") {
    expect(CPU.count > 0)
    expect(CPU.count < 256)
}

test.case("CPUTotalCount") {
    expect(CPU.totalCount > 0)
    expect(CPU.totalCount < 256)
}

test.run()
