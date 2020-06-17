//
//  checkFitVC.swift
//  SizyApp
//
//  Created by 임명준 on 2020/06/10.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class CheckFitVC: UIViewController {

    let fitCategoryView = FitCategoryView()
    
    override func loadView() {
        view = fitCategoryView
        view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = AppStrings.chhecFitTitle.rawValue
        
    }
}
