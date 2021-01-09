//
//  GameOverViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit

class GameOverViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?

    @IBOutlet weak var scoreText: UILabel!
    var score: Int64 = 0
    var gameMode = 0
    var keyGenerationStrategy: KeyGenerationStrategy!
    
    @IBAction func playAgainPressed(_ sender: UIButton) {
        keyGenerationStrategy.reset()
        coordinator?.playGame(gameMode: gameMode, keyGenerationStrategy: keyGenerationStrategy)
    }
    
    @IBAction func goToMenuPressed(_ sender: UIButton) {
        coordinator?.mainMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreText.text = "Score: \(score)"
    }
}
