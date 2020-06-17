//
//  ApplicationCoordinator.swift
//  SizyApp
//
//  Created by 임명준 on 2020/06/16.
//  Copyright © 2020 임명준. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinatable{
    private var navigationController: UINavigationController!
    private var mainCoordinator: Coordinatable
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.mainCoordinator = MainCoordinator(navigationController)
    }
    func activate() {
        mainCoordinator.activate()
    }
}

class MainCoordinator: Coordinatable{
  
    private var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func activate() {
        let rootController = ViewController()
        navigationController.pushViewController(rootController, animated: true)
    }
}

