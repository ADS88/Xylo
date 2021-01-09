//
//  EnterHighScoreViewController.swift
//  Xylophone
//
//  Created by Andrew on 9/01/21.
//

import UIKit

class EnterHighScoreViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var scoreLabel: UILabel!
    weak var coordinator: MainCoordinator?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var score: Int64 = 0
    var gameMode = 0
    var keyGenerationStrategy: KeyGenerationStrategy!

    @IBAction func continueButtonPressed(_ sender: UIButton) {
        createHighScore()
        coordinator?.gameOver(gameMode: gameMode, keyGenerationStrategy: keyGenerationStrategy!, score: score)
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score)

        // Do any additional setup after loading the view.
    }
    
    func createHighScore(){
        let highScore = HighScore(context: context)
        highScore.name = nameTextField.text 
        highScore.score = score
        highScore.date = Date()
        try! self.context.save()
    }
}
