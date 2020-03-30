// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "lor-deckcodes",
    products: [
        .executable(
            name: "lor-deckcodes",
            targets: ["cli"]),
        .library(
            name: "LoRDeckCodes",
            targets: ["LoRDeckCodes"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .exact("0.0.4")),
    ],
    targets: [
        .target(
            name: "cli",
            dependencies: [
                "LoRDeckCodes",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .target(
            name: "LoRDeckCodes",
            dependencies: []),
        .testTarget(
            name: "Tests",
            dependencies: ["LoRDeckCodes"]),
    ]
)
