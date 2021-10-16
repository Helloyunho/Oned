// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Oned",
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "Oned",
            dependencies: []),
        .testTarget(
            name: "OnedTests",
            dependencies: ["Oned"]),
    ])
