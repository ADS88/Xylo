//
//  RandomKeyGenerationStrategy.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import Foundation

struct RandomKeyGenerationStrategy : KeyGenerationStrategy {
    
    var leastKeysPlayed = 1
    var mostKeysPlayed = 2
    var sounds = [String]()
    
    mutating func generateKeys() -> [String] {
        var items = [String]()
        let numKeys = Int.random(in: leastKeysPlayed...mostKeysPlayed)
        for _ in 0...numKeys{
            items.append(sounds.randomElement()!)
        }
        leastKeysPlayed += 1
        mostKeysPlayed += 1
        return items
    }
    
    mutating func reset(){
        leastKeysPlayed = 1
        mostKeysPlayed = 2
    }
    
    init(sounds: [String]) {
        self.sounds = sounds
    }
}
