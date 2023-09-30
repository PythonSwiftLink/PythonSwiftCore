// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "PythonSwiftLink",
	platforms: [.macOS(.v11), .iOS(.v13)],
	products: [
		.library(
			name: "PythonSwiftCore",
			targets: ["PythonSwiftCore", "PythonLib"]
		),
		.library(
			name: "PySwiftObject",
			targets: ["PySwiftObject"]
		),
	],
	dependencies: [
		//.package(url: "https://github.com/PythonSwiftLink/PythonTestSuite", branch: "master"),
	],
	
	targets: [
			.target(
				name: "PythonSwiftCore",
				dependencies: [
					"PythonLib",
					"PythonTypeAlias"
				],
				resources: [
					
				],
				swiftSettings: [ .define("BEEWARE", nil)]
			),
		
			.target(
				name: "PySwiftObject",
				dependencies: [
					"PythonLib",
					"PythonTypeAlias"
				],
				resources: [
					
				],
				swiftSettings: [ .define("BEEWARE", nil)]
			),

			.target(
				name: "PythonLib",
				dependencies: ["Python"],
				path: "Sources/PythonLib",
				linkerSettings: [
					.linkedLibrary("ncurses"),
					.linkedLibrary("sqlite3"),
					.linkedLibrary("z"),
				]
			),
			.target(
				name: "PythonTypeAlias",
				dependencies: [
					"PythonLib",
				]
			),
			
		.binaryTarget(name: "Python", path: "Sources/PythonLib/Python.xcframework"),

	]
)
