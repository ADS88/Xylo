//
//  SongKeyGenerationStrategy.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import Foundation

struct SongKeyGenerationStrategy : KeyGenerationStrategy {
    
    var notes = [String]()
    var sounds = [String]()
    var keysToPlay = 1
    
    mutating func generateKeys() -> [String] {
        var i = 0
        var items = [String]()
        keysToPlay = Int.random(in: keysToPlay + 1...keysToPlay + 3)
        while i < min(notes.count, keysToPlay){
            items.append(notes[i])
            i += 1
        }
        return items
    }
    
    mutating func reset(){
        keysToPlay = 1
    }
    
    init(notes: [String], sounds: [String]) {
        self.notes = notes
        self.sounds = sounds
    }
    
}
