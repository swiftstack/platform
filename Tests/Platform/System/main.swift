import Test
import Platform

test("Int") {
    expect(throws: SystemError()) {
        try system { -1 }
    }
}

test("OpaquePointer") {
    expect(throws: SystemError()) {
        try system { nil as OpaquePointer? }
    }
}

test("GenericPointer") {
    expect(throws: SystemError()) {
        try system { nil as UnsafeMutablePointer<Int>? }
    }
}

await run()
