//
//  Coordinator.swift
//  FetchEvents
//
//  Created by Deanne Chance on 11/25/23.
//

import Foundation
import UIKit

protocol Coordinator : AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
