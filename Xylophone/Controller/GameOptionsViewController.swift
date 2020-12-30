//
//  GameOptionsViewController.swift
//  Xylophone
//
//  Created by Andrew on 30/12/20.
//

import UIKit
import iCarousel

class GameOptionsViewController: UIViewController, iCarouselDataSource {
    
    struct GameMode {
        let title: String
        let description: String
    }
    
    let gameModes = [GameMode(title: "Classic", description: "Classic gamemode"),
                     GameMode(title: "Pitch Detection", description: "Pitch detection"),
                     GameMode(title: "Chord detection", description: "Chord detection")
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
        descriptionLabel.frame = CGRect(x: 20, y: 20, width: view.frame.size.width, height: 100)
        view.addSubview(descriptionLabel)
        
        return view
    }
}
