//
//  HighScoreViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit
import CoreData

class HighScoreViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    let highScoreBrain = HighScoreBrain()

    @IBOutlet weak var highScoreTableView: UITableView!
    
    var scores = [HighScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scores = highScoreBrain.getTopTenScores()
        let nib = UINib(nibName: "HighScoreTableViewCell", bundle: nil )
        highScoreTableView.register(nib, forCellReuseIdentifier: "HighScoreTableViewCell")
        highScoreTableView.dataSource = self
    }
}

extension HighScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let highScoreCell: HighScoreTableViewCell = {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreTableViewCell", for: indexPath) as! HighScoreTableViewCell
            cell.nameLabel.text = scores[indexPath.row].name
            cell.scoreLabel.text = String(scores[indexPath.row].score)
            cell.layoutIfNeeded()
            return cell
        }()
        
        if indexPath.row % 2 == 0 {
            highScoreCell.surroundingBlockView.backgroundColor = UIColor(named: "xyloBlue")
        } else {
            highScoreCell.nameLabel.textColor = UIColor(named: "xyloBlue")
            highScoreCell.scoreLabel.textColor = UIColor(named: "xyloBlue")
        }
        
        return highScoreCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scores.count == 0 {
            self.highScoreTableView.setEmptyMessage("Play a game to create a high score!")
        } else {
            self.highScoreTableView.restore()
        }

        return scores.count
    }
    
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
