//
//  AddressCoderBech32.swift
//  WalletLibAddressBech32
//
//

import Foundation
import WalletLibCrypto.Bech32


public struct AddressCoderBech32 {
    
    
    public static func data(from prefix: String) -> Data {
        
        let bytes = prefix.utf8.map({
            $0 & 0x1f
        })
        
        return Data(bytes)
    }
    
    
    public static func hrpExpand(prefix: String) -> Data {
        
        let bytes = prefix.utf8.map({
            $0 & 0x1f
        })
        
        let expand = prefix.map({ ($0.asciiValue ?? 0) >> 5 }) + [0x00] + bytes.map({ $0 & 31 })
        
        return Data(expand)
    }
    
    
    public static func polymod(data: Data, output: Data, gen: AddressCoderBech32GeneratorProtocol) -> Data {
        
        let input = data + output
        let generator = gen.value
        
        var checksum: UInt64 = 1

        for i in 0..<input.count {
            
            let value = UInt64(input[i])
            let topBits = checksum >> gen.shift
            checksum = ((checksum & gen.mask) << 5) ^ value

            for j in 0..<generator.count {
                
                if (topBits >> j) & 1 == 1 {
                    
                    checksum = checksum ^ generator[j]
                    
                }
                
            }
            
        }

        let result = checksum ^ 1

        var bytes = output
        let index = bytes.count - 1
        
        for i in 0..<bytes.count {
            
            bytes[index - i] = UInt8( (result >> (5*i)) & UInt64(0x1f) )
            
        }

        return bytes
    }
    
    
    /// Using for encode Bech32 BitcoinSegwit address aka BC1
    /// - Parameters:
    ///   - hrp: Human readable prefix
    ///   - witnessVersion: Version
    ///   - witnessProgram: Witness program data
    /// - Returns: Bech32 encoded BitcoinSegwit address
    public static func encode(hrp: String, witnessVersion: UInt8, witnessProgram: Data, gen: AddressCoderBech32GeneratorProtocol) -> String {
        
        let convert = Bech32.convertBits(witnessProgram, from: 8, to: 5, strict: false)
        let payload = witnessVersion.data + convert
        
        let prefix = AddressCoderBech32.hrpExpand(prefix: hrp)
        let checksum = AddressCoderBech32.polymod(data: prefix + payload, output: Data(count: 6), gen: gen)
        
        return Bech32.encode(payload + checksum, converted: true)
    }
    
    
    public static func encode(hrp: String, data: Data, gen: AddressCoderBech32GeneratorProtocol) -> String {
        
        let convert = Bech32.convertBits(data, from: 8, to: 5, strict: false)
        let payload = convert
        
        let prefix = AddressCoderBech32.hrpExpand(prefix: hrp)
        let checksum = AddressCoderBech32.polymod(data: prefix + payload, output: Data(count: 6), gen: gen)
        
        return Bech32.encode(payload + checksum, converted: true)
    }
    
    
    public static func decode(witness address: String, hrp: AddressHRP, gen: AddressCoderBech32GeneratorProtocol) -> Data {
        
        let payload = address.dropPrefix(prefix: hrp.description)
        let decoded = Bech32.decode(payload, convert: false)
        
        let checksum = polymod(data: AddressCoderBech32.hrpExpand(prefix: hrp.prefix) + decoded.dropLast(6), output: Data(count: 6), gen: gen)
        
        guard checksum == decoded.suffix(6) else {
            
            return Data()
            
        }
        
        let converted = Bech32.convertBits(decoded.dropFirst().dropLast(6), from: 5, to: 8, strict: true)
        let result = converted
        
        return result
    }
    
    
}
