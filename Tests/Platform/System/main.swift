import Test
import Platform

test.case("Int") {
    expect(throws: SystemError()) {
        try system { -1 }
    }
}

test.case("OpaquePointer") {
    expect(throws: SystemError()) {
        try system { nil as OpaquePointer? }
    }
}

test.case("GenericPointer") {
    expect(throws: SystemError()) {
        try system { nil as UnsafeMutablePointer<Int>? }
    }
}

await test.run()
