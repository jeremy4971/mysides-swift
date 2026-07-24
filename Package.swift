// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "mysides-swift",
    platforms: [
        .macOS(.v26)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0")
    ],
    targets: [
        .executableTarget(
            name: "mysides",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .testTarget(
            name: "mysidesTests",
            dependencies: ["mysides"]
        )
    ]
)
