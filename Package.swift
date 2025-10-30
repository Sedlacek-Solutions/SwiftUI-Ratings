// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUI-Ratings",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "Ratings",
            targets: ["Ratings"]),
    ],
    targets: [
        .target(
            name: "Ratings",
            resources: [
                .process("Media.xcassets")
            ]
        )
    ]
)
