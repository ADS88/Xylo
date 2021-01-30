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
    let keyboardNotes = ["lowC", "D", "E", "F", "G", "A", "B", "highC"]
    var gameModes: [GameModeOption]
    let songs = Songs()

    required init?(coder aDecoder: NSCoder) {
        self.gameModes = [GameModeOption(title: "Memory", description: "Repeat the notes that are played on the screen", color: UIColor(named: "xyloPurple") ?? .purple, imageName: "music.quarternote.3", gameMode: .MEMORY),
            GameModeOption(title: "Pitch Detection", description: "Repeat the notes that you hear being played", color: UIColor(named: "xyloBlue") ?? .blue, imageName: "music.note", gameMode: .PITCH_IDENTIFICATION),
            GameModeOption(title: "Free Play", description: "Free play on the keyboard", color: UIColor(named: "xlyoGreen") ?? .lightGray, imageName: "scribble", gameMode: .FREE_PLAY),
            GameModeOption(title:"Mary had a little lamb", description: "Play Mary had a little lamb", color: UIColor(named: "xyloOrange") ?? .orange, imageName: "smiley", notes: songs.maryHadALittleLamb, gameMode: .SONG),
            GameModeOption(title: "Happy birthday", description: "Play happy birthday", color: UIColor(named: "xyloOrange") ?? .orange, imageName: "crown", notes: songs.happyBirthday, gameMode: .SONG),
            GameModeOption(title: "Twinkle twinkle little star", description: "Play twinkle twinkle little star", color: UIColor(named: "xyloOrange") ?? .orange, imageName: "star", notes: songs.twinkleStar, gameMode: .SONG),
            GameModeOption(title: "Imperial March", description: "play imperial march", color: UIColor(named: "xyloOrange") ?? .orange, imageName: "moon.stars", notes: songs.imperialMarch, gameMode: .SONG),
            GameModeOption(title: "Lord of the rings", description: "play lord of the rings", color: UIColor(named: "xyloOrange") ?? .orange, imageName: "sun.dust", notes: songs.shireTheme, gameMode: .SONG),
            GameModeOption(title: "Jingle Bells", description: "play jingle bells", color: UIColor(named: "xyloOrange") ?? .orange, imageName: "bell", notes: songs.jingleBells, gameMode: .SONG)
        ]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(carousel)
        carousel.type = .rotary
        carousel.dataSource = self
        carousel.delegate = self
    }
    
    
    @objc
    func startGame(){
        let keyGenerationStrategy: KeyGenerationStrategy
        let gameModeOption = gameModes[carousel.currentItemIndex]
        if gameModeOption.gameMode == GameMode.SONG {
            keyGenerationStrategy = SongKeyGenerationStrategy(notes: gameModeOption.notes)
        } else {
            keyGenerationStrategy = RandomKeyGenerationStrategy(sounds: ["lowC", "D", "E", "F", "G", "A", "B", "highC"])
        }
        self.coordinator?.playGame(gameMode: gameModeOption.gameMode.rawValue, keyGenerationStrategy: keyGenerationStrategy)
    }
    
}

extension GameOptionsViewController: iCarouselDataSource, iCarouselDelegate {
   
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let view = GameModeOptionView()
        view.layer.cornerRadius = 20
        view.frame.size = CGSize(width: self.view.frame.size.width/1.2, height: self.view.frame.size.height / 1.2)
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
}


