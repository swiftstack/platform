import Test
import Platform

test.case("Int") {
    await expect(throws: SystemError()) {
        try system { -1 }
    }
}

test.case("OpaquePointer") {
    await expect(throws: SystemError()) {
        try system { nil as OpaquePointer? }
    }
}

test.case("GenericPointer") {
    await expect(throws: SystemError()) {
        try system { nil as UnsafeMutablePointer<Int>? }
    }
}

test.run()
