//
//  RandomKeyGenerationStrategy.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import Foundation

struct RandomKeyGenerationStrategy : KeyGenerationStrategy {
    
    func generateKeys(sounds: [String], leastKeysPlayed: Int, mostKeysPlayed: Int) -> [String] {
        var items = [String]()
        let numKeys = Int.random(in: leastKeysPlayed...mostKeysPlayed)
        for _ in 0...numKeys{
            items.append(sounds.randomElement()!)
        }
        return items
    }
    
}
