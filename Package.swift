// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InfiniteScrollView",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "InfiniteScrollView",
            targets: ["InfiniteScrollView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector.git", from: "0.10.0")
    ],
    targets: [
        .target(
            name: "InfiniteScrollView"),
        .testTarget(
            name: "InfiniteScrollViewTests",
            dependencies: ["InfiniteScrollView", "ViewInspector"]
        ),
    ]
)
