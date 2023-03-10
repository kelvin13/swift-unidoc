// swift-tools-version:5.7
import PackageDescription

let package:Package = .init(
    name: "swift-unidoc",
    platforms: [.macOS(.v11)],
    products:
    [
        .library(name: "Declarations", targets: ["Declarations"]),
        .library(name: "Generics", targets: ["Generics"]),

        .library(name: "Packages", targets: ["Packages"]),
        .library(name: "PackageManifest", targets: ["PackageManifest"]),
        .library(name: "PackageResolution", targets: ["PackageResolution"]),

        .library(name: "SemanticVersions", targets: ["SemanticVersions"]),

        .library(name: "SymbolAvailability", targets: ["SymbolAvailability"]),
        .library(name: "SymbolResolution", targets: ["SymbolResolution"]),
        .library(name: "Symbols", targets: ["Symbols"]),
        .library(name: "SymbolGraphs", targets: ["SymbolGraphs"]),
    ],
    dependencies: 
    [
        .package(url: "https://github.com/kelvin13/swift-json", .upToNextMinor(from: "0.4.5")),

        .package(url: "https://github.com/kelvin13/swift-grammar", .upToNextMinor(from: "0.3.1")),
        .package(url: "https://github.com/kelvin13/swift-hash", .upToNextMinor(from: "0.5.0")),
        .package(url: "https://github.com/kelvin13/swift-mongodb", .upToNextMinor(from: "0.1.10")),
        
        .package(url: "https://github.com/apple/swift-system.git", .upToNextMinor(from: "1.2.1")),
    ],
    targets:
    [
        .target(name: "Declarations"),

        .target(name: "Generics"),

        .target(name: "Packages", dependencies:
            [
                .target(name: "SemanticVersions"),
            ]),

        .target(name: "PackageManifest", dependencies:
            [
                .target(name: "Packages"),
                .target(name: "Symbols"),

                .product(name: "JSONDecoding", package: "swift-json"),
                .product(name: "JSONEncoding", package: "swift-json"),
            ]),

        .target(name: "PackageResolution", dependencies:
            [
                .target(name: "Packages"),

                .product(name: "JSONDecoding", package: "swift-json"),
                .product(name: "JSONEncoding", package: "swift-json"),
            ]),

        .target(name: "SemanticVersions"),

        .target(name: "Symbols"),

        .target(name: "SymbolAvailability", dependencies:
            [
                .target(name: "SemanticVersions"),
                .target(name: "Symbols"),
            ]),

        .target(name: "SymbolResolution", dependencies:
            [
                .target(name: "Symbols"),

                .product(name: "JSONDecoding", package: "swift-json"),
                .product(name: "JSONEncoding", package: "swift-json"),
            ]),

        .target(name: "SymbolGraphs", dependencies:
            [
                .target(name: "Declarations"),
                .target(name: "Generics"),
                .target(name: "System"),
                .target(name: "SymbolAvailability"),
                .target(name: "SymbolResolution"),
            ]),
        
        .target(name: "System", dependencies:
            [
                .product(name: "SystemPackage", package: "swift-system"),
            ]),

        
        .executableTarget(name: "DeclarationsTests", dependencies:
            [
                .target(name: "Declarations"),
                .product(name: "Testing", package: "swift-grammar"),
            ],
            path: "Tests/Declarations"),
        
        .executableTarget(name: "PackageManifestTests", dependencies:
            [
                .target(name: "PackageManifest"),
                .target(name: "System"),
                .product(name: "Testing", package: "swift-grammar"),
            ],
            path: "Tests/PackageManifest"),

        .executableTarget(name: "PackageResolutionTests", dependencies:
            [
                .target(name: "PackageResolution"),
                .target(name: "System"),
                .product(name: "Testing", package: "swift-grammar"),
            ],
            path: "Tests/PackageResolution"),
        
        .executableTarget(name: "SemanticVersionsTests", dependencies:
            [
                .target(name: "SemanticVersions"),
                .product(name: "Testing", package: "swift-grammar"),
            ],
            path: "Tests/SemanticVersions"),
        
        .executableTarget(name: "SymbolResolutionTests", dependencies:
            [
                .target(name: "SymbolResolution"),
                .product(name: "Testing", package: "swift-grammar"),
            ],
            path: "Tests/SymbolResolution"),
        
        .executableTarget(name: "SymbolGraphsTests", dependencies:
            [
                .target(name: "SymbolGraphs"),
                .target(name: "System"),
                .product(name: "Testing", package: "swift-grammar"),
            ],
            path: "Tests/SymbolGraphs",
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]),
    ])
