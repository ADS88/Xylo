//
//  ViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit
import AVFoundation
import CoreData

class GameViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?

    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var keyGenerationStrategy : KeyGenerationStrategy!
    var player: AVAudioPlayer?
    let sounds = ["C", "D", "E", "F", "G", "A", "B"]
    var expectedSounds = [String]()
    var currentIndex = 0
    var buttons = [UIButton]()
    var soundToButton = [String:UIButton]()
    var score: Int64 = 0
    var gameMode: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [cButton, dButton, eButton, fButton, gButton, aButton, bButton]
        soundToButton = [
            "C": cButton,
            "D": dButton,
            "E": eButton,
            "F": fButton,
            "G": gButton,
            "A": aButton,
            "B": bButton
        ]
        newSetOfKeys()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        let sound = sounds[sender.tag]
        playSound(soundName: sound)
        buttonOpaqueOnClickEffect(button: sender, newOpacity: 0.5)
        if sound == expectedSounds[currentIndex] {
            currentIndex += 1
            score += 1
            scoreLabel.text = "Score: \(score)"
        } else {
            gameOver()
        }
        if currentIndex >= expectedSounds.count {
            newSetOfKeys()
        }
    }
    
    func gameOver(){
        addUserMoney()
        if shouldCreateHighScore(){
            coordinator?.enterHighScoreName(gameMode: gameMode, keyGenerationStrategy: keyGenerationStrategy, score: score)
        } else {
            coordinator?.gameOver(gameMode: gameMode, keyGenerationStrategy: keyGenerationStrategy, score: score)
        }
    }
    
    func shouldCreateHighScore() -> Bool{
        return true
    }
    
    func addUserMoney(){
        var userMoney = UserDefaults.standard.integer(forKey: "userMoney")
        userMoney += Int(score)
        UserDefaults.standard.set(userMoney, forKey: "userMoney")
    }
    
    func buttonOpaqueOnClickEffect(button: UIButton, newOpacity: CGFloat){
        let oringinalAlpha = button.alpha
        button.alpha = newOpacity
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              button.alpha = oringinalAlpha
          }
    }
    
    func newSetOfKeys(){
        expectedSounds = keyGenerationStrategy.generateKeys()
        if expectedSounds.isEmpty{
            gameOver()
        }
        currentIndex = 0
        setKeysClickable(to: false)
        playKeys(expectedSounds)
    }
    
    func playKeys(_ keys: [String]){
        var delay: Double = 1.0
        for key in keys{
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.playSound(soundName: key)
                if self.gameMode != GameMode.PITCH_IDENTIFICATION.rawValue {
                    self.buttonOpaqueOnClickEffect(button: self.soundToButton[key]! ,newOpacity: 0.0)
                }
            }
            delay += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setKeysClickable(to: true)
        }
    }
    
    func setKeysClickable(to isEnabled: Bool){
        buttons.forEach{button in button.isEnabled = isEnabled}
    }
    
    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
    }

}

