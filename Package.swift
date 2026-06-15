// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "UselessOiiaiCat",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "UselessOiiaiCat", targets: ["UselessOiiaiCat"])
    ],
    targets: [
        .executableTarget(
            name: "UselessOiiaiCat",
            path: ".",
            exclude: [
                ".build",
                ".github",
                ".gitignore",
                "README.md",
                "dist",
                "scripts"
            ],
            sources: [
                "Sources/UselessOiiaiCat"
            ],
            resources: [
                .copy("assets")
            ]
        )
    ]
)
