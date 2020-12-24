//
//  GameOverViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var scoreText: UILabel!
    let score = 34
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreText.text = "Score: \(score)"
    }
    
}
