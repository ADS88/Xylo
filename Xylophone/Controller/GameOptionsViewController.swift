//
//  GameOptionsViewController.swift
//  Xylophone
//
//  Created by Andrew on 30/12/20.
//

import UIKit
import iCarousel

class GameOptionsViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var carousel: iCarousel!
    @IBOutlet weak var songPickerView: UIPickerView!
    
    
    let songs = [Song(name:"Mary had a little lamb", notes:  ["B", "A", "G", "A", "B", "B", "B", "A", "A", "A", "B", "B", "B", "B", "A", "G", "A", "B", "B", "B", "B", "A", "A", "B", "A", "G"]),
                 Song(name: "Happy birthday", notes: ["lowC", "lowC", "D", "lowC", "F", "E", "lowC", "lowC", "D", "C", "G", "F", "lowC", "lowC", "highC", "A", "F", "E", "D", "highC", "highC", "A", "F", "G", "F"]),
                 Song(name: "Twinkle twinkle little star", notes: ["lowC", "lowC", "G", "G", "A", "A", "G", "F", "F", "E", "E", "D", "D", "lowC", "G", "G", "F", "F", "E", "E", "D", "G", "G", "F", "F", "E", "E", "D", "lowC", "lowC", "G", "G", "A", "A", "G", "F", "F", "E", "E", "D", "D", "lowC"]),
                 Song(name: "Imperial March", notes: ["E", "E", "E", "lowC", "G", "E", "lowC", "G", "E", "B", "B", "B", "highC", "G", "E", "lowC", "G", "E", ])
    ]
    
    var chosenSong: Song!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chosenSong = songs[0]
        view.addSubview(carousel)
        carousel.type = .rotary
        carousel.dataSource = self
        carousel.delegate = self
        songPickerView.delegate = self
        songPickerView.dataSource = self
        updatePickerVisibility()
    }
    
    
    @objc
    func startGame(){
        let keyGenerationStrategy: KeyGenerationStrategy
        if carousel.currentItemIndex == GameMode.SONG.rawValue {
            keyGenerationStrategy = SongKeyGenerationStrategy(notes: chosenSong.notes)
        } else {
            keyGenerationStrategy = RandomKeyGenerationStrategy(sounds: ["lowC", "D", "E", "F", "G", "A", "B", "highC"])
        }
        self.coordinator?.playGame(gameMode: carousel.currentItemIndex, keyGenerationStrategy: keyGenerationStrategy)
    }
    
    
    let gameModes = [GameModeOption(title: "Memory", description: "Notes will appear to be tapped on the screen. Tap the correct notes back to gain points. The amount of notes to remember increases over time ", color: UIColor(named: "xyloPurple") ?? .purple, imageName: "music.quarternote.3"),
                     GameModeOption(title: "Pitch Detection", description: "Notes will be played without visual indication. Tap the correct notes back to gain points. The amount of notes to remember increases over time", color: UIColor(named: "xyloBlue") ?? .blue, imageName: "music.note"),
                     GameModeOption(title: "Song Mode", description: "Notes of a chosen song will be played visual indication. Tap the correct notes back to gain points. The amount of notes to remember increases over time", color: UIColor(named: "xyloOrange") ?? .orange, imageName: "music.note.list"),
                     GameModeOption(title: "Free Play", description: "Jam out on the keyboard", color: UIColor(named: "xlyoGreen") ?? .lightGray, imageName: "scribble")
    ]
    
}

extension GameOptionsViewController: iCarouselDataSource, iCarouselDelegate {
    func carouselDidScroll(_ carousel: iCarousel) {
        updatePickerVisibility()
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let view = GameModeOptionView()
        view.layer.cornerRadius = 20
        view.frame.size = CGSize(width: self.view.frame.size.width/1.2, height: self.view.frame.size.height / 1.4)
        view.backgroundColor = gameModes[index].color
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.startGame))
        view.addGestureRecognizer(tapGesture)
        
        let image = UIImage(systemName: gameModes[index].imageName)
        view.optionImage.image = image
        view.optionTitle.text = gameModes[index].title
        view.optionDescription.text = gameModes[index].description
        
        
        return view
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return gameModes.count
    }
    
    func updatePickerVisibility(){
        if carousel.currentItemIndex == GameMode.SONG.rawValue {
            songPickerView.isHidden = false
        } else {
            songPickerView.isHidden = true
        }
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        updatePickerVisibility()
    }
}

extension GameOptionsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenSong = songs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return songs[row].name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return songs.count
    }
    
}

