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
    var userMoney: Int64 = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var amountButton: UIBarButtonItem!
    var currentlyUsedItemName = "default"
    
    override func viewDidLoad() {
        userMoney = Int64(UserDefaults.standard.integer(forKey: "userMoney"))
        currentlyUsedItemName = UserDefaults.standard.string(forKey: "currentKeyboard")!
        
        let image = UIImage(systemName: "bitcoinsign.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "xyloBlue")!)
       
        let coinButton = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        
        
        amountButton = UIBarButtonItem(title: "\(userMoney)", style: .plain, target: self, action: nil)
        
        navigationItem.setRightBarButtonItems([amountButton, coinButton], animated: false)
        super.viewDidLoad()
        getShopItems()
        carousel.type = .rotary
        carousel.dataSource = self
        carousel.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(userMoney, forKey: "userMoney")
        UserDefaults.standard.set(currentlyUsedItemName, forKey: "currentKeyboard")
    }
    
    func getShopItems(){
        let request: NSFetchRequest = ShopItem.fetchRequest()
        do {
            shopItems = try context.fetch(request)
        } catch {
            print("error")
        }
    }
    
    func purchaseShopItem(shopItem: ShopItem){
        if userMoney >= shopItem.cost {
            shopItem.hasBeenPurchased = true
            do {
                try context.save()
                userMoney -= shopItem.cost
                amountButton.title = "\(userMoney)"
            } catch {
                print("error")
            }
            
        } else {
            print("too poor")
        }
    }
    
    func switchCurrentKeyboard(shopItem: ShopItem){
        currentlyUsedItemName = shopItem.name!
    }
    
    @objc
    func buttonClicked(){
        let shopItem = shopItems[carousel.currentItemIndex]
        if shopItem.hasBeenPurchased {
            switchCurrentKeyboard(shopItem: shopItem)
        } else {
            purchaseShopItem(shopItem: shopItem)
        }
        UIView.transition(with: carousel, duration: 0.35, options: .transitionCrossDissolve, animations: { () -> Void in
            self.carousel!.reloadData()
        }, completion: nil)
       
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
        
        if shopItem.hasBeenPurchased {
            view.shopItemButton.setTitle("Use", for: .normal)
            view.shopItemButton.backgroundColor = .blue
        } else if shopItem.cost >= userMoney {
            view.shopItemButton.isEnabled = false
        }
        if shopItem.name == currentlyUsedItemName {
            view.shopItemButton.isHidden = true
        }
            
            
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.buttonClicked))
        view.shopItemButton.addGestureRecognizer(tapGesture)
        
        return view
    }
}
