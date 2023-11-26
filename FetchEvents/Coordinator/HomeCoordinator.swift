//
//  HomeCoordinator.swift
//  FetchEvents
//
//  Created by Deanne Chance on 11/25/23.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        print("Home coordinator started")
        gotoHomePage()
    }
    
    init(parentCoordinator: Coordinator, navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gotoHomePage() {
        let eventsViewController = EventsViewController()
        navigationController.pushViewController(eventsViewController, animated: false)
    }
    
    
}
