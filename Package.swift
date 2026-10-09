// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "GKPhotoBrowser",
    platforms: [
        .iOS(.v12) // 和原库最低支持版本一致，可根据项目调整
    ],
    products: [
        .library(name: "GKPhotoBrowserCore", targets: ["GKPhotoBrowserCore"]),
        .library(name: "GKPhotoBrowser-Kingfisher", targets: ["GKPhotoBrowser-KF"]),
        .library(name: "GKPhotoBrowser-SDWebImage", targets: ["GKPhotoBrowser-SD"]),
        .library(name: "GKPhotoBrowser-AVPlayer", targets: ["GKPhotoBrowser-AVPlayer"])
    ],
    dependencies: [
        // Kingfisher 依赖，版本范围可根据项目调整
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
        // SDWebImage 依赖
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.8.0")
    ],
    targets: [
        // 核心模块，对应 pod 'GKPhotoBrowser/Core'
        .target(
            name: "GKPhotoBrowserCore",
            path: "GKPhotoBrowser/Core",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .define("GKPhotoBrowser_Core", to: "1")
            ]
        ),
        
        // Kingfisher 适配模块，对应 pod 'GKPhotoBrowser/KF'
        .target(
            name: "GKPhotoBrowser-KF",
            dependencies: [
                "GKPhotoBrowserCore",
                .product(name: "Kingfisher", package: "Kingfisher")
            ],
            path: "GKPhotoBrowser/KF",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("../Core")
            ]
        ),
        
        // SDWebImage 适配模块，对应 pod 'GKPhotoBrowser/SD'
        .target(
            name: "GKPhotoBrowser-SD",
            dependencies: [
                "GKPhotoBrowserCore",
                .product(name: "SDWebImage", package: "SDWebImage")
            ],
            path: "GKPhotoBrowser/SD",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("../Core")
            ]
        ),
        
        // AVPlayer 视频模块，对应 pod 'GKPhotoBrowser/AVPlayer'
        .target(
            name: "GKPhotoBrowser-AVPlayer",
            dependencies: ["GKPhotoBrowserCore"],
            path: "GKPhotoBrowser/AVPlayer",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("../Core")
            ],
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("UIKit")
            ]
        )
    ]
)
