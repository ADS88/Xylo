//
//  ViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer?
    let sounds = ["C", "D", "E", "F", "G", "A", "B"]
    var expectedSounds = [String]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expectedSounds = generateKeys(lower: 3, upper: 7)
        playKeys(expectedSounds)
        // Do any additional setup after loading the view.
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        let sound = sounds[sender.tag]
        playSound(soundName: sound)
        buttonOpaqueOnClickEffect(button: sender)
        if sound == expectedSounds[currentIndex] {
            currentIndex += 1
            print("right key")
        } else {
            self.performSegue(withIdentifier: "goToGameOver", sender: self)
        }
    }
    
    func buttonOpaqueOnClickEffect(button: UIButton){
        button.alpha = 0.5
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              button.alpha = 1.0
          }
    }
    
    func generateKeys(lower: Int, upper: Int) -> [String] {
        var items = [String]()
        let numKeys = Int.random(in: lower...upper)
        for _ in 0...numKeys{
            items.append(sounds.randomElement()!)
        }
        return items
    }
    
    func playKeys(_ keys: [String]){
        var delay: Double = 1.0
        for key in keys{
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.playSound(soundName: key)
            }
            delay += 1
        }
    }
    
    func playSound(soundName: String) {
        print(soundName)
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

