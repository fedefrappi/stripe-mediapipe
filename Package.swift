// swift-tools-version:6.1
import PackageDescription

let version = "1.0.0"
let assets = "https://github.com/fedefrappi/stripe-mediapipe/releases/download/\(version)"

let package = Package(
    name: "MediaPipeSPM",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "MediaPipeSPM",
            targets: ["MediaPipeSPMRuntime"]
        ),
    ],
    targets: [
        .target(
            name: "MediaPipeSPMRuntime",
            dependencies: [
                "MediaPipeSPMGraphReferences",
                "MediaPipeSPMLinkSupport",
                "MediaPipeTasksVision",
            ]
        ),
        .target(
            name: "MediaPipeSPMGraphReferences",
            dependencies: [
                "MediaPipeCommonGraphLibraries",
                "MediaPipeTasksCommon",
            ],
            publicHeadersPath: "include"
        ),
        .target(
            name: "MediaPipeSPMLinkSupport",
            dependencies: [
                "MediaPipeCommonGraphLibraries",
                "MediaPipeTasksCommon",
                "MediaPipeTasksVision",
            ],
            linkerSettings: [
                .linkedFramework("CoreMedia"),
                .linkedFramework("CoreVideo"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("Accelerate"),
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
            ]
        ),
        .binaryTarget(
            name: "MediaPipeTasksVision",
            url: "\(assets)/MediaPipeTasksVision.xcframework.zip",
            checksum: "8c1038dd24d8b0e72dfc4a7891f7f4367e53484345d223d35e85797859b9e961"
        ),
        .binaryTarget(
            name: "MediaPipeCommonGraphLibraries",
            url: "\(assets)/MediaPipeCommonGraphLibraries.xcframework.zip",
            checksum: "09d55d7dc4fe74c571fdc3650fd90513de19fdaea033e5f8dc9a7cae712fd411"
        ),
        .binaryTarget(
            name: "MediaPipeTasksCommon",
            url: "\(assets)/MediaPipeTasksCommon.xcframework.zip",
            checksum: "786e8d8768963b807b73ff158033cfa2d796dcb82a5854b794b7285742b8fe78"
        ),
    ]
)
