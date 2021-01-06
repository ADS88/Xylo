//
//  Coordinator.swift
//  Xylophone
//
//  Created by Andrew on 6/01/21.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
}
