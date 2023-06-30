//
//  AddressCoderBech32GeneratorProtocol.swift
//  WalletLibAddressBech32
//
//

import Foundation


public protocol AddressCoderBech32GeneratorProtocol {
    
    
    var value: [UInt64] { get }
    
    
    var shift: UInt64 { get }
    
    
    var mask: UInt64 { get }
    
    
}
