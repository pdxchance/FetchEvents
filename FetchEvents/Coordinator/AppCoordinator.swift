//
//  AppCoordinator.swift
//  FetchEvents
//
//  Created by Deanne Chance on 11/25/23.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        gotoHomePage()
    }
    
    func gotoHomePage() {
        let homeCoordinator = HomeCoordinator.init(parentCoordinator: self, navigationController: navigationController)
        children.append(homeCoordinator)
        
        homeCoordinator.start()
    }
    
    
}
