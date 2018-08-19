// swift-tools-version:4.2

// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

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
    targets: targets,
    swiftLanguageVersions: [.v4_2]
)
