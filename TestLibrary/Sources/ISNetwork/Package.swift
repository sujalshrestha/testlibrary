// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ISNetwork",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "ISNetwork", targets: ["ISNetwork"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.4"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2")
    ],
    targets: [
        .target(name: "ISNetwork", dependencies: ["Alamofire", "KeychainAccess"])
    ]
)
