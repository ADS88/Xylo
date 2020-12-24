//
//  ViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var player: AVAudioPlayer?
    let sounds = ["C", "D", "E", "F", "G", "A", "B"]

    @IBAction func keyPressed(_ sender: UIButton) {
        playSound(soundName: sounds[sender.tag])
        buttonOpaqueOnClickEffect(button: sender)
    }
    
    func buttonOpaqueOnClickEffect(button: UIButton){
        button.alpha = 0.5
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              button.alpha = 1.0
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

