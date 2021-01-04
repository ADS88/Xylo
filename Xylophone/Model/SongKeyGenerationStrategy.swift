//
//  SongKeyGenerationStrategy.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import Foundation

struct SongKeyGenerationStrategy : KeyGenerationStrategy {
    
    var currentIndex = 0
    let song = ["B", "A", "G", "A", "B", "B", "B", "A", "A", "A", "B", "B", "B", "B", "A", "G", "A", "B", "B", "B", "B", "A", "A", "B", "A", "G"]
    
    mutating func generateKeys(sounds: [String], leastKeysPlayed: Int, mostKeysPlayed: Int) -> [String] {
        var items = [String]()
        var numKeys = Int.random(in: leastKeysPlayed...mostKeysPlayed)
        while currentIndex < song.count && numKeys > 0 {
            items.append(song[currentIndex])
            currentIndex += 1
            numKeys -= 1
        }
        return items
    }
    
    func shouldContinuePlaying() -> Bool {
        return currentIndex < song.count
    }
}
