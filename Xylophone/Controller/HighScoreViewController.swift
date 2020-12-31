//
//  HighScoreViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit
import CoreData

class HighScoreViewController: UIViewController {

    @IBOutlet weak var highScoreTableView: UITableView!
    
    var scores = [HighScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        let nib = UINib(nibName: "HighScoreTableViewCell", bundle: nil )
        highScoreTableView.register(nib, forCellReuseIdentifier: "HighScoreTableViewCell")
        highScoreTableView.delegate = self
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
            for score in scores {
                print(score.score)
            }
        } catch {
            print("error")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HighScoreViewController: UITableViewDelegate {
    
}

extension HighScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreTableViewCell", for: indexPath) as! HighScoreTableViewCell
        cell.nameLabel.text = scores[indexPath.row].name
        cell.scoreLabel.text = String(scores[indexPath.row].score)
        for constraint in cell.surroundingBlockView.constraints {
            print(constraint.identifier)
            if constraint.identifier == "distanceFromRight" {
                print("yowza")
                constraint.constant = constraint.constant + CGFloat(10 * indexPath.row)
            }
        }
        
        if indexPath.row % 3 == 0 {
            cell.surroundingBlockView.backgroundColor = UIColor(named: "xyloBlue")
        } else if indexPath.row % 3 == 1 {
            cell.surroundingBlockView.backgroundColor = UIColor(named: "xyloOrange")
        }
        
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return scores.count
    }
}
