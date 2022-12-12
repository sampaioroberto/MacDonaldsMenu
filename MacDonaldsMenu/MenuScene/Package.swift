// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MenuScene",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MenuScene",
            targets: ["MenuScene"])
    ],
    dependencies: [
        .package(name: "UI", path: "UI"),
        .package(name: "Network", path: "Network")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MenuScene",
            dependencies: [
                .product(name: "UI", package: "UI"),
                .product(name: "Network", package: "Network")
            ]),
        .testTarget(
            name: "MenuSceneTests",
            dependencies: ["MenuScene"])
    ]
)
