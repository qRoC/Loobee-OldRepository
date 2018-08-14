// swift-tools-version:4.2

import PackageDescription

var targets: [PackageDescription.Target] = [
    .target(name: "CLoobeeCore", dependencies: []),
    .target(name: "LoobeeCore", dependencies: ["CLoobeeCore"]),
    .testTarget(name: "LoobeeCoreTests", dependencies: ["LoobeeCore"]),
]

let package = Package(
    name: "Loobee",
    products: [
        .library(name: "LoobeeCore", targets: ["LoobeeCore"]),
    ],
    targets: targets
)
