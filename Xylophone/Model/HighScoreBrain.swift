//
//  HighScoreBrain.swift
//  Xylophone
//
//  Created by Andrew on 9/01/21.
//

import UIKit
import CoreData

struct HighScoreBrain {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getTopTenScores() -> [HighScore] {
        var scores = [HighScore]()
        let request: NSFetchRequest = HighScore.fetchRequest()
        request.fetchLimit = 10
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        do {
            scores = try context.fetch(request)
        } catch {
            print("error")
        }
        return scores
    }
    
    func shouldCreateHighScore(score: Int64) -> Bool {
        let scores = getTopTenScores()
        if scores.isEmpty {
            return true
        }
        return score > scores.last!.score
    }
    
    func createHighScore(name: String, score: Int64){
        let highScore = HighScore(context: context)
        highScore.name = name
        highScore.score = score
        highScore.date = Date()
        try! self.context.save()
    }
}
