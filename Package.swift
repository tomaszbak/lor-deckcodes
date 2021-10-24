// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "lor-deckcodes",
    products: [
        .executable(
            name: "lor-deckcodes",
            targets: ["cli"]
        ),
        .library(
            name: "LoRDeckCodes",
            targets: ["LoRDeckCodes"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .exact("1.0.1")),
    ],
    targets: [
        .executableTarget(
            name: "cli",
            dependencies: [
                "LoRDeckCodes",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .target(
            name: "LoRDeckCodes",
            dependencies: []
        ),
        .testTarget(
            name: "Tests",
            dependencies: ["LoRDeckCodes"],
            resources: [
                .copy("Resources")
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
