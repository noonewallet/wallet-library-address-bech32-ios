//
//  AddressHRP.swift
//  WalletLibAddressBech32
//
//

import Foundation


public struct AddressHRP: CustomStringConvertible {
    
    
    public var prefix: String
    
    
    public var separator: String
    
    
    public var description: String { prefix + separator }
    
    
    public init(prefix: String, separator: String) {
    
        self.prefix = prefix
        self.separator = separator
    }
    
    
}
