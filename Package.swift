// swift-tools-version:5.5
import PackageDescription

let deps: [Target.Dependency] = [
    "SwiftCLI",
]

let package = Package(
    name: "Oned",
    products: [
        .executable(name: "Oned", targets: ["Oned"])
    ],
    dependencies: [
        .package(url: "https://github.com/jakeheis/SwiftCLI", .upToNextMajor(from: "6.0.3")),
    ],
    targets: [
        .executableTarget(
            name: "Oned",
            dependencies: deps
        ),
        .testTarget(
            name: "OnedTests",
            dependencies: ["Oned"])
    ]
)

#if os(Linux)
deps.append(
    .target(name: "JavaScriptCore", condition: .when(platforms: [.linux]))
)
package.targets = [
    .executableTarget(
        name: "Oned",
        dependencies: deps
    )
    .testTarget(
        name: "OnedTests",
        dependencies: ["Oned"]),
    .systemLibrary(
        name: "JavaScriptCore",
        pkgConfig: "javascriptcoregtk-4.0",
        providers: [.apt(["libjavascriptcoregtk-4.0-dev"])]
    )
]
#endif
