//
//  GameOptionsViewController.swift
//  Xylophone
//
//  Created by Andrew on 30/12/20.
//

import UIKit
import iCarousel

class GameOptionsViewController: UIViewController, iCarouselDataSource {
    
    let gameModes = [GameModeOption(title: "Memory", description: "Memory gamemode"),
                     GameModeOption(title: "Pitch Detection", description: "Pitch detection"),
                     GameModeOption(title: "Chord detection", description: "Chord detection")
    ]
    
    let carousel: iCarousel = {
        let view = iCarousel()
        view.type = .rotary
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(carousel)
        carousel.dataSource = self
        carousel.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 400)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.4, height: 300))
        view.backgroundColor = .lightGray
        
        let titleLabel = UILabel()
        titleLabel.text = gameModes[index].title
        titleLabel.frame = CGRect(x: 20, y: 0, width: view.frame.size.width, height: 100)
        view.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = gameModes[index].description
        descriptionLabel.frame = CGRect(x: 20, y: 50, width: view.frame.size.width, height: 100)
        view.addSubview(descriptionLabel)
        
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame"{
            
            let destinationVC = segue.destination as! GameViewController
            destinationVC.gameMode = carousel.currentItemIndex
        }
    }
}
