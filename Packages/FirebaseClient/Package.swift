// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseClient",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "FirebaseClient",
            targets: ["FirebaseClient"]),
    ],
    dependencies: [
        .package(path: "../Models"),
        .package(
           name: "Firebase",
           url: "https://github.com/firebase/firebase-ios-sdk.git",
           from: "9.0.0"
        )
    ],
    targets: [
        .target(
            name: "FirebaseClient",
            dependencies: [
                "Models",
                .product(name: "FirebaseAnalytics", package: "Firebase"),
                .product(name: "FirebaseRemoteConfig", package: "Firebase"),
                .product(name: "FirebaseFirestore", package: "Firebase"),
            ]),
        .testTarget(
            name: "FirebaseClientTests",
            dependencies: ["FirebaseClient"]),
    ]
)
