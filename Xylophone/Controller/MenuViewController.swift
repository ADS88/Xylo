//
//  MenuViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit

class MenuViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?

    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        coordinator?.gameOptions()
    }
    
    @IBAction func highScoreButtonClicked(_ sender: UIButton) {
        coordinator?.highScores()
    }
    
    @IBAction func shopButtonClicked(_ sender: UIButton) {
        coordinator?.shop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
