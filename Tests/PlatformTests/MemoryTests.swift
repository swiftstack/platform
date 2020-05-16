import Test
import Platform

class MemoryTests: TestCase {
    func testPage() {
        expect(Memory.Page.size == 4096)
        expect(Memory.Page.count > 1024)
    }

    func testSize() {
        expect(Memory.size > 1024)
    }

    func testSizeRepresentation() {
        expect(String(.byte) == "1 B")

        expect(String(.kibibyte) == "1 KiB")
        expect(String(.mebibyte) == "1 MiB")
        expect(String(.gibibyte) == "1 GiB")
        expect(String(.tebibyte) == "1 TiB")
        expect(String(.pebibyte) == "1 PiB")

        expect(String(.kilobyte, units: .decimal(.kilobytes)) == "1 kB")
        expect(String(.megabyte, units: .decimal(.megabytes)) == "1 MB")
        expect(String(.gigabyte, units: .decimal(.gigabytes)) == "1 GB")
        expect(String(.terabyte, units: .decimal(.terabytes)) == "1 TB")
        expect(String(.petabyte, units: .decimal(.petabytes)) == "1 PB")
    }

    func testSizeRepresentationRounding() {
        expect(String(Memory.Size(bytesCount: 1023)) == "1023 B")
        expect(String(Memory.Size(bytesCount: 1029)) == "1 KiB")
        expect(String(Memory.Size(bytesCount: 1030)) == "1.01 KiB")
    }
}
