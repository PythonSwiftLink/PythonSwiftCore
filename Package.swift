// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PythonSwiftCore",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
//        .library(
//            name: "PythonSwiftCore",
//            targets: ["PythonSwiftCore"]
//        ),
        .library(
            name: "PythonSwiftCore",
            targets: ["PythonSwiftCore"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        //.package(path: "../PythonLib"),
        .package(url: "https://github.com/PythonSwiftLink/PythonLib", branch: "main"),
        //.package(path: "../PythonLib")
        //.package(url: "https://github.com/PythonSwiftLink/PythonLib-iOS", branch: "main")
    ],
    targets: [
        .target(
            name: "PythonSwiftCore",
            dependencies: [
                "PythonLib",
                //.product(name: "PythonLib", package: "PythonLib", condition: .when(platforms: [.macOS])),
                //"PythonLib-iOS",
                //.product(name: "PythonLib-iOS", package: "PythonLib-iOS", condition: .when(platforms: [.iOS])),
            ],
            
            swiftSettings: [ .define("BEEWARE", nil)]
        ),
//        .target(
//            name: "PythonSwiftCore-iOS",
//            dependencies: ["PythonLib-iOS"],
//            path: "./Sources/PythonSwiftCore",
//            swiftSettings: [ .define("BEEWARE", nil)]
//        )
//        .testTarget(
//            name: "PSL_CoreTests",
//            dependencies: ["PSL_Core"]),
    ]
)
