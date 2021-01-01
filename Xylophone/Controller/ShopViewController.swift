//
//  ShopViewController.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import UIKit
import CoreData

class ShopViewController: UIViewController {
    
    override func viewDidLoad() {
        var shopItems = [ShopItem]()
        super.viewDidLoad()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest = ShopItem.fetchRequest()
        print("hello")
        do {
            shopItems = try context.fetch(request)
            for item in shopItems {
                print(item.name)
            }
        } catch {
            print("error")
        }
    }

}
