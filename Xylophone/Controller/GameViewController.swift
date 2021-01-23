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

    @IBOutlet weak var lowCButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var highCButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let highScoreBrain = HighScoreBrain()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var keyGenerationStrategy : KeyGenerationStrategy!
    var player: AVAudioPlayer?
    let sounds = ["lowC", "D", "E", "F", "G", "A", "B", "highC"]
    var expectedSounds = [String]()
    var currentIndex = 0
    var buttons = [UIButton]()
    var soundToButton = [String:UIButton]()
    var score: Int64 = 0
    var gameMode: Int = 0
    let keyboardAppearanceHelper = KeyboardAppearanceHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [lowCButton, dButton, eButton, fButton, gButton, aButton, bButton, highCButton]
        keyboardAppearanceHelper.setupKeyboard(buttons, withAppearance: UserDefaults.standard.string(forKey: "currentKeyboard")!)
        soundToButton = [
            "lowC": lowCButton,
            "D": dButton,
            "E": eButton,
            "F": fButton,
            "G": gButton,
            "A": aButton,
            "B": bButton,
            "highC": highCButton
        ]
        if gameMode == GameMode.FREE_PLAY.rawValue{
            scoreLabel.alpha = 0.0
        } else {
            newSetOfKeys()
        }
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        let sound = sounds[sender.tag]
        playSound(soundName: sound)
        buttonOpaqueOnClickEffect(button: sender, newOpacity: 0.5)
        if gameMode != GameMode.FREE_PLAY.rawValue{
            checkIfKeyisCorrect(sound)
        }
    }
    
    func checkIfKeyisCorrect(_ sound: String){
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
    
    func gameOver(finishedText: String = "Game Over!"){
        addUserMoney()
        if highScoreBrain.shouldCreateHighScore(score: score){
            coordinator?.enterHighScoreName(gameMode: gameMode, keyGenerationStrategy: keyGenerationStrategy, score: score, finishedText: finishedText)
        } else {
            coordinator?.gameOver(gameMode: gameMode, keyGenerationStrategy: keyGenerationStrategy, score: score, finishedText: finishedText)
        }
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
            gameOver(finishedText: "Finished Song!")
        }
        currentIndex = 0
        setKeysClickable(to: false)
        playKeys(expectedSounds)
    }
    
    func playKeys(_ keys: [String]){
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
            if i < keys.count {
                self.playSound(soundName: keys[i])
                if self.gameMode != GameMode.PITCH_IDENTIFICATION.rawValue {
                    self.buttonOpaqueOnClickEffect(button: self.soundToButton[keys[i]]! ,newOpacity: 0.0)
                }
                i += 1
            } else {
                self.setKeysClickable(to: true)
                timer.invalidate()
            }
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

