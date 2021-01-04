//
//  GameOptionsViewController.swift
//  Xylophone
//
//  Created by Andrew on 30/12/20.
//

import UIKit
import iCarousel

class GameOptionsViewController: UIViewController, iCarouselDataSource {
    
    let gameModes = [GameModeOption(title: "Memory", description: "Notes will appear to be tapped on the screen. Tap the correct notes back to gain points. The amount of notes to remember increases over time ", color: UIColor(named: "xyloPurple") ?? .purple, imageName: "music.quarternote.3"),
                     GameModeOption(title: "Pitch Detection", description: "Notes will be played without visual indication. Tap the correct notes back to gain points. The amount of notes to remember increases over time", color: UIColor(named: "xyloBlue") ?? .blue, imageName: "music.note"),
                     GameModeOption(title: "Song Mode", description: "Notes of a chosen song will be played visual indication. Tap the correct notes back to gain points. The amount of notes to remember increases over time", color: UIColor(named: "xyloOrange") ?? .orange, imageName: "music.note.list")
    ]
    
    @IBOutlet weak var carousel: iCarousel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(carousel)
        carousel.type = .rotary
        carousel.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let view = GameModeOptionView()
        view.layer.cornerRadius = 20
        view.frame.size = CGSize(width: self.view.frame.size.width/1.2, height: self.view.frame.size.height / 1.4)
        view.backgroundColor = gameModes[index].color

        let image = UIImage(systemName: gameModes[index].imageName)
        view.optionImage.image = image
        view.optionTitle.text = gameModes[index].title
        view.optionDescription.text = gameModes[index].description
       
        
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame"{
            
            let destinationVC = segue.destination as! GameViewController
            destinationVC.gameMode = carousel.currentItemIndex
            if carousel.currentItemIndex == GameMode.SONG.rawValue {
                destinationVC.keyGenerationStrategy = SongKeyGenerationStrategy()
            } else {
                destinationVC.keyGenerationStrategy = RandomKeyGenerationStrategy()
            }
        }
    }
}
