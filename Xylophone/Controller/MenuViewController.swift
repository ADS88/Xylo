//
//  MenuViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit

class MenuViewController: UIViewController {

    @IBAction func playButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGameOptions", sender: self)
    }
    
    @IBAction func highScoreButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToHighScore", sender: self)
    }
    
    @IBAction func shopButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToShop", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
