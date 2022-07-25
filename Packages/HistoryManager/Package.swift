// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HistoryManager",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "HistoryManager",
            targets: ["HistoryManager"]),
    ],
    dependencies: [
        .package(path: "../Models"),
    ],
    targets: [
        .target(
            name: "HistoryManager",
            dependencies: ["Models"]),
        .testTarget(
            name: "HistoryManagerTests",
            dependencies: ["HistoryManager"]),
    ]
)
