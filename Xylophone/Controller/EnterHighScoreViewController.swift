//
//  EnterHighScoreViewController.swift
//  Xylophone
//
//  Created by Andrew on 9/01/21.
//

import UIKit

class EnterHighScoreViewController: UIViewController, Storyboarded, UITextFieldDelegate {
    
    @IBOutlet weak var scoreLabel: UILabel!
    weak var coordinator: MainCoordinator?
    
    let highScoreBrain = HighScoreBrain()
    
    var score: Int64 = 0
    var gameMode = 0
    var keyGenerationStrategy: KeyGenerationStrategy!

    @IBAction func continueButtonPressed(_ sender: UIButton) {
        var name = "Unknown"
        if let text = nameTextField.text, !text.isEmpty {
            name = text
            UserDefaults.standard.set(name, forKey: "userName")
        }
        highScoreBrain.createHighScore(name: name, score: score)
        coordinator?.gameOver(gameMode: gameMode, keyGenerationStrategy: keyGenerationStrategy!, score: score)
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        scoreLabel.text = String(score)
        nameTextField.text = UserDefaults.standard.string(forKey: "userName")

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
