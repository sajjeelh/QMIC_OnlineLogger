// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QMIC_OnlineLogger",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "QMIC_OnlineLogger",
            targets: ["QMIC_OnlineLogger"]),
    ],
    dependencies: [
        
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "QMIC_OnlineLogger"),
        .testTarget(
            name: "OnlineLoggerTests",
            dependencies: ["QMIC_OnlineLogger"]),
    ]
)
