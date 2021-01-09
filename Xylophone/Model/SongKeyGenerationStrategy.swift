//
//  SongKeyGenerationStrategy.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import Foundation

struct SongKeyGenerationStrategy : KeyGenerationStrategy {
    
    var currentIndex = 0
    var notes = [String]()
    var sounds = [String]()
    var leastKeysPlayed = 1
    var mostKeysPlayed = 2
    
    mutating func generateKeys() -> [String] {
        var items = [String]()
        var numKeys = Int.random(in: leastKeysPlayed...mostKeysPlayed)
        while currentIndex < notes.count && numKeys > 0 {
            items.append(notes[currentIndex])
            currentIndex += 1
            numKeys -= 1
        }
        leastKeysPlayed += 1
        mostKeysPlayed += 1
        return items
    }
    
    mutating func reset(){
        currentIndex = 0
        leastKeysPlayed = 1
        mostKeysPlayed = 2
    }
    
    init(notes: [String], sounds: [String]) {
        self.notes = notes
        self.sounds = sounds
    }
    
}
