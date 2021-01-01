//
//  KeyGenerationStrategy.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import Foundation

protocol KeyGenerationStrategy {
    func generateKeys(sounds: [String], leastKeysPlayed: Int, mostKeysPlayed: Int) -> [String]
}
