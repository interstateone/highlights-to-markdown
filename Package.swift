// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "highlights-to-markdown",
    products: [
        .executable(name: "h2m", targets: ["highlights-to-markdown"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "highlights-to-markdown",
            dependencies: [])
    ],
    swiftLanguageVersions: [.v4_2]
)
