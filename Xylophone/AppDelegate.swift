//
//  AppDelegate.swift
//  Xylophone
//
//  Created by Andrew on 24/12/20.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preloadDataIfNotExists()
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
    
    // MARK: - Core Data stack
    
    private func preloadDataIfNotExists(){
        let preloadedDataKey = "didPreloadData"
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            userDefaults.set(200, forKey: "userMoney")
            userDefaults.set("Standard keyboard", forKey: "currentKeyboard")
            preloadData(key: preloadedDataKey, userDefaults: userDefaults)
        }
    }
    
    private func preloadData(key preloadedDataKey: String, userDefaults: UserDefaults){
        guard let urlPath = Bundle.main.url(forResource: "preloadeddata", withExtension: ".plist") else { return }
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            let contents = NSDictionary(contentsOf: urlPath) as! [String: Int]
            do {
                for (name, cost) in contents {
                    let shopItem = ShopItem(context: backgroundContext)
                    shopItem.name = name
                    shopItem.cost = Int64(cost)
                    shopItem.hasBeenPurchased = false
                    shopItem.imageName = shopItem.name
                }
                let defaultKeyboard = ShopItem(context: backgroundContext)
                defaultKeyboard.name = "Standard Keyboard"
                defaultKeyboard.cost = 0
                defaultKeyboard.hasBeenPurchased = true
                defaultKeyboard.imageName = "Standard Keyboard"
                try backgroundContext.save()
                userDefaults.setValue(true, forKey: preloadedDataKey)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Xylophone")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }



}

