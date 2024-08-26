import Testing
import Platform

@Test("Int")
func int() async throws {
    #expect(throws: SystemError()) {
        try system { -1 }
    }
}

@Test("OpaquePointer")
func opaquePointer() async throws {
    #expect(throws: SystemError()) {
        try system { nil as OpaquePointer? }
    }
}

@Test("UnsafeMutablePointer<Int>")
func genericPointer() async throws {
    #expect(throws: SystemError()) {
        try system { nil as UnsafeMutablePointer<Int>? }
    }
}
