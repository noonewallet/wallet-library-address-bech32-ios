// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "wallet-library-address-bech32-ios",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "WalletLibAddressBech32",
            targets: ["WalletLibAddressBech32"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/noonewallet/wallet-library-crypto-ios.git", branch: "feature/spm-support")
    ],
    targets: [
        .target(
            name: "WalletLibAddressBech32",
            dependencies: [
                .product(name: "WalletLibCryptoSwift", package: "wallet-library-crypto-ios")
            ]
        ),
        .testTarget(
            name: "WalletLibAddressBech32Tests",
            dependencies: ["WalletLibAddressBech32"]
        )
    ]
)
