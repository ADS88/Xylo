//
//  KeyGenerationStrategy.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import Foundation

protocol KeyGenerationStrategy {
    mutating func generateKeys() -> [String]
    mutating func reset()
}
