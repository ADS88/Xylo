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

    @IBOutlet weak var highScoreTableView: UITableView!
    
    var scores = [HighScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        let nib = UINib(nibName: "HighScoreTableViewCell", bundle: nil )
        highScoreTableView.register(nib, forCellReuseIdentifier: "HighScoreTableViewCell")
        highScoreTableView.dataSource = self
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest = HighScore.fetchRequest()
        request.fetchLimit = 10
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        do {
            scores = try context.fetch(request)
        } catch {
            print("error")
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return scores.count
    }
    
}
