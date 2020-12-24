//
//  GameOverViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var scoreText: UILabel!
    var score: Int64 = 0
    
    @IBAction func playAgainPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "playAgain", sender: self)
    }
    
    @IBAction func goToMenuPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToMenu", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreText.text = "Score: \(score)"
    }
    
}
