// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "lor-deckcodes",
    products: [
        .library(name: "LoRDeckCodes", targets: ["LoRDeckCodes"]),
    ],
    targets: [
        .target(
            name: "LoRDeckCodes",
            dependencies: []),
        .testTarget(
            name: "Tests",
            dependencies: ["LoRDeckCodes"]),
    ]
)
