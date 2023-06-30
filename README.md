
[![License](https://img.shields.io/badge/license-MIT-black.svg?style=flat)](https://mit-license.org)
[![Platform](https://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/resources/)
[![Swift](https://img.shields.io/badge/swift-5.0-brightgreen.svg)](https://developer.apple.com/resources/)
[![Version](https://img.shields.io/badge/Version-1.0-orange.svg)]()

![Noone core](https://github.com/noonewallet/noone-android-core-crypto/assets/111989613/1f062349-24d4-4824-9c00-b8f2724eca51)

## WalletLibAddressBech32

The WalletLibAddressBech32 library is an implementation of tools related to Bech32 addresses.

## Requirements

* macOS 12.6
* XCode Version 14.2

## Installation

Using `CocoaPods`. 

Clone or download repo, add the following line to your `Podfile`

```ruby
# platform :ios, '10.0'

target 'YourTargetName' do
  use_frameworks!
  
  pod 'WalletLibAddressBech32', :path => 'path/to/WalletLibAddressBech32' 
end
```

## Usage

#### Encoding address
```swift

  let publicKey = Data(hex: "02173a1b9d95417fae24a73136eefe8b4f835f6b629cf3b131862368b665919fc1")

  let address = AddressCoderBech32.encode(hrp: "ltc", witnessVersion: 0x00, witnessProgram: publicKey.ripemd160sha256(), gen: AddressCoderBech32GeneratorBC1())

  //ltc1qj9e5pvtspzqe4hzznv0xxsuvy4njsujwclv0ft

```

#### Decoding address
```swift

  let hrp = AddressHRP(prefix: "ltc", separator: "1")

  let data = AddressCoderBech32.decode(witness: "ltc1qj9e5pvtspzqe4hzznv0xxsuvy4njsujwclv0ft", hrp: hrp, gen: AddressCoderBech32GeneratorBC1())

```


## Created using
- [_WalletLibCrypto_](https://github.com/noonewallet/wallet-library-crypto-ios)

## License

MIT. See the [_LICENSE_](LICENSE) file for more info.
