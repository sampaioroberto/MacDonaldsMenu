// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MenuDetailsScene",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MenuDetailsScene",
            targets: ["MenuDetailsScene"]),
    ],
    dependencies: [
        .package(name: "UI", path: "UI")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MenuDetailsScene",
            dependencies: [
                .product(name: "UI", package: "UI")
            ]),
        .testTarget(
            name: "MenuDetailsSceneTests",
            dependencies: ["MenuDetailsScene"]),
    ]
)
