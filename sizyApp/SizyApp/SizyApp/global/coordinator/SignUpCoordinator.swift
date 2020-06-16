//
//  SignUpCoordinator.swift
//  SizyApp
//
//  Created by 임명준 on 2020/06/16.
//  Copyright © 2020 임명준. All rights reserved.
//

import Foundation
import UIKit

class SignUpCoordinator: Coordinatable{
    private var navigationController: UINavigationController!
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func activate() {
        let goEmailSignup = LoginWithEmailVC()
        navigationController.pushViewController(goEmailSignup, animated: true)
    }
}
