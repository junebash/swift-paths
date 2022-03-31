// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "swift-paths",
    products: [
        .library(
            name: "Paths",
            targets: ["Paths"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-case-paths", branch: "main")
    ],
    targets: [
        .target(
            name: "Paths",
            dependencies: [
                .product(name: "CasePaths", package: "swift-case-paths")
            ]
        ),
        .testTarget(
            name: "PathsTests",
            dependencies: ["Paths"]
        ),
    ]
)
