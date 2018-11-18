import Test
import Platform

class MemoryTests: TestCase {
    func testSize() {
        assertTrue(Memory.size > 1024)
    }

    func testSizeRepresentation() {
        assertEqual(String(.byte), "1 B")

        assertEqual(String(.kibibyte), "1 KiB")
        assertEqual(String(.mebibyte), "1 MiB")
        assertEqual(String(.gibibyte), "1 GiB")
        assertEqual(String(.tebibyte), "1 TiB")
        assertEqual(String(.pebibyte), "1 PiB")

        assertEqual(String(.kilobyte, units: .decimal(.kilobytes)), "1 kB")
        assertEqual(String(.megabyte, units: .decimal(.megabytes)), "1 MB")
        assertEqual(String(.gigabyte, units: .decimal(.gigabytes)), "1 GB")
        assertEqual(String(.terabyte, units: .decimal(.terabytes)), "1 TB")
        assertEqual(String(.petabyte, units: .decimal(.petabytes)), "1 PB")
    }

    func testSizeRepresentationRounding() {
        assertEqual(String(Memory.Size(bytesCount: 1023)), "1023 B")
        assertEqual(String(Memory.Size(bytesCount: 1029)), "1 KiB")
        assertEqual(String(Memory.Size(bytesCount: 1030)), "1.01 KiB")
    }
}
