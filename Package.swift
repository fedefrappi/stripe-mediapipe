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
            checksum: "0000000000000000000000000000000000000000000000000000000000000000"
        ),
        .binaryTarget(
            name: "MediaPipeCommonGraphLibraries",
            url: "\(assets)/MediaPipeCommonGraphLibraries.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000"
        ),
        .binaryTarget(
            name: "MediaPipeTasksCommon",
            url: "\(assets)/MediaPipeTasksCommon.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000"
        ),
    ]
)
