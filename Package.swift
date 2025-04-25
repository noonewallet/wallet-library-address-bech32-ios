// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "wallet-library-address-bech32-ios",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "WalletLibraryAddressBech32IOS",
            targets: ["WalletLibraryAddressBech32IOS"]
        )
    ],
    targets: [
        .target(
            name: "WalletLibraryAddressBech32IOS",
            path: "Sources/WalletLibraryAddressBech32IOS"
        ),
        .testTarget(
            name: "WalletLibraryAddressBech32IOSTests",
            dependencies: ["WalletLibraryAddressBech32IOS"],
            path: "Tests/WalletLibraryAddressBech32IOSTests"
        )
    ]
)
