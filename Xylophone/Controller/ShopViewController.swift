//
//  ShopViewController.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import UIKit
import CoreData
import iCarousel

class ShopViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var carousel: iCarousel!
    weak var coordinator: MainCoordinator?
    var shopItems = [ShopItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getShopItems()
        carousel.type = .rotary
        carousel.dataSource = self
        carousel.delegate = self
        
    }
    
    func getShopItems(){
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

extension ShopViewController: iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return shopItems.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let view = ShopItemView()
        view.layer.cornerRadius = 20
        view.frame.size = CGSize(width: self.view.frame.size.width/1.2, height: self.view.frame.size.height / 1.4)
        view.backgroundColor = .red
        view.shopItemTitle.text = shopItems[index].name
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.startGame))
//        view.addGestureRecognizer(tapGesture)
//
//        let image = UIImage(systemName: gameModes[index].imageName)
//        view.optionImage.image = image
//        view.optionTitle.text = gameModes[index].title
//        view.optionDescription.text = gameModes[index].description
       
        
        return view
    }
}
