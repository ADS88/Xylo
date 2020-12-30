//
//  HighScoreViewController.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit
import CoreData

class HighScoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest = HighScore.fetchRequest()
        request.fetchLimit = 3
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        do {
            let scores: [HighScore] = try context.fetch(request)
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
