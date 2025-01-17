// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestLibrary",
    platforms: [
        .iOS(.v14) // Define minimum supported iOS version
    ],
    products: [
        // The library product makes the package visible to other packages or apps.
        .library(
            name: "TestLibrary",
            targets: ["TestLibrary"]
        ),
    ],
    dependencies: [
        // Add external package dependencies here, if any.
    ],
    targets: [
        // Define the main target for the library.
        .target(
            name: "TestLibrary",
            dependencies: [], // Add dependencies for this target, if any.
            path: "TestLibrary/Sources/TestLibrary", // Specify the source files location
            exclude: [], // List files to exclude, if any.
            resources: [
                //                .process("Resources") // Include resource files like images, XIBs, etc.
            ]
        ),
        // Define a test target for unit tests.
        .testTarget(
            name: "TestLibraryTests",
            dependencies: ["TestLibrary"],
            path: "Tests/TestLibraryTests" // Specify the test files location.
        ),
    ]
)
