// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HistoryManager",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "HistoryManager",
            targets: ["HistoryManager"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HistoryManager",
            dependencies: []),
        .testTarget(
            name: "HistoryManagerTests",
            dependencies: ["HistoryManager"]),
    ]
)
