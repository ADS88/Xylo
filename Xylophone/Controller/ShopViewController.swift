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
    var userMoney = 0
    
    override func viewDidLoad() {
        userMoney = UserDefaults.standard.integer(forKey: "userMoney")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(userMoney)", style: .plain, target: self, action: nil)
        super.viewDidLoad()
        getShopItems()
        carousel.type = .rotary
        carousel.dataSource = self
        carousel.delegate = self
        
    }
    
    func getShopItems(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest = ShopItem.fetchRequest()
        do {
            shopItems = try context.fetch(request)
        } catch {
            print("error")
        }
    }
    
    @objc
    func buttonClicked(){
        print(shopItems[carousel.currentItemIndex].cost)
    }
}

extension ShopViewController: iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return shopItems.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let view = ShopItemView()
        view.frame.size = CGSize(width: self.view.frame.size.width/1.2, height: self.view.frame.size.height / 1.4)
        let shopItem = shopItems[index]
        view.shopItemTitle.text = shopItem.name
        let image = UIImage(named: shopItem.imageName!)
        view.shopItemImage.image = image
        view.layer.borderColor = UIColor(named: "xyloPurple")?.cgColor
        view.shopItemCost.text = String(shopItem.cost)
        view.shopItemButton.isHidden = shopItem.hasBeenPurchased
        //view.shopItemButton.isEnabled = shopItem.cost 
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.buttonClicked))
        view.shopItemButton.addGestureRecognizer(tapGesture)
        
        return view
    }
}
