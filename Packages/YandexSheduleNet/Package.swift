// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "YandexSheduleNet",
	platforms: [.macOS(.v10_15), .iOS(.v13)],
	products: [
		.library(name: "YandexSheduleNet", targets: ["YandexSheduleNet"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
		.package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
		.package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
	],
	targets: [
		.target(
			name: "YandexSheduleNet",
			dependencies: [
				.product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
				.product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
			],
			plugins: [
				.plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator"),
			]
		),
		.testTarget(
			name: "YandexSheduleNetTests",
			dependencies: ["YandexSheduleNet"]),
	]
)
