// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "GKPhotoBrowser",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "GKPhotoBrowserCore", targets: ["GKPhotoBrowserCore"]),
        .library(name: "GKPhotoBrowser-Kingfisher", targets: ["GKPhotoBrowser-KF"]),
        .library(name: "GKPhotoBrowser-SDWebImage", targets: ["GKPhotoBrowser-SD"]),
        .library(name: "GKPhotoBrowser-AVPlayer", targets: ["GKPhotoBrowser-AVPlayer"])
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.8.0")
    ],
    targets: [
        // 核心模块：基础浏览功能，无第三方依赖
        .target(
            name: "GKPhotoBrowserCore",
            path: "GKPhotoBrowser/Core",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath(".")
            ],
            linkerSettings: [
                .linkedFramework("UIKit"),
                .linkedFramework("Foundation"),
                .linkedFramework("Photos")
            ]
        ),
        
        // Kingfisher 图片加载适配
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
        
        // SDWebImage 图片加载适配
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
        
        // AVPlayer 视频播放适配
        .target(
            name: "GKPhotoBrowser-AVPlayer",
            dependencies: ["GKPhotoBrowserCore"],
            path: "GKPhotoBrowser/AVPlayer",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("../Core")
            ],
            linkerSettings: [
                .linkedFramework("AVFoundation")
            ]
        )
    ]
)
