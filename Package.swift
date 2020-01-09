// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "highlights-to-markdown",
    platforms: [.macOS(.v10_10)],
    products: [
        .executable(name: "h2m", targets: ["highlights-to-markdown"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "highlights-to-markdown",
            dependencies: [],
            linkerSettings: [.linkedFramework("PDFKit")])
    ],
    swiftLanguageVersions: [.v5]
)
