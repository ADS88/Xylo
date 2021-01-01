//
//  SongKeyGenerationStrategy.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import Foundation

struct SongKeyGenerationStrategy {
    
    var currentIndex = 0
    let song = ["A"]
    
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
    
    
}
