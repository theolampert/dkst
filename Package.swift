// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dkst",
    products: [
        .executable(name: "dkst", targets: ["Dkst"])
    ],
    dependencies: [
      .package(url: "https://github.com/kylef/Commander", from: "0.8.0")
    ],
    targets: [
        .target(
            name: "DkstLib",
            dependencies: ["Commander"]),
        .target(
            name: "Dkst",
            dependencies: ["DkstLib"]),
        .testTarget(
            name: "DkstTests",
            dependencies: ["DkstLib"]),
    ]
)
