// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Platform",
    products: [
        .library(name: "Platform", targets: ["Platform"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-stack/test.git",
            .branch("master"))
    ],
    targets: [
        .target(name: "Platform"),
        .testTarget(name: "PlatformTests", dependencies: ["Platform", "Test"])
    ]
)
