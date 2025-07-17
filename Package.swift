// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CXCalendar",
    platforms: [
        // Platforms define the platforms that this package supports.
        // .iOS(.v17, // Minimum iOS version
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CXCalendar",
            targets: ["CXCalendar"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Cunqi/CXLazyPage.git", branch: "master"),
        .package(url: "https://github.com/Cunqi/CXUICore.git", branch: "master"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CXCalendar",
            dependencies: [
                .product(name: "CXLazyPage", package: "CXLazyPage"),
                .product(name: "CXUICore", package: "CXUICore"),
            ]
        ),
        .testTarget(
            name: "CXCalendarTests",
            dependencies: ["CXCalendar"]
        ),
    ]
)
