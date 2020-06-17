//
//  InputSizeVC.swift
//  SizyApp
//
//  Created by 임명준 on 2020/06/10.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class InputSizeVC: UIViewController {

    private var mainCategory: String!
    private var subCategory: String!
    
    init(mainCategory: String,subCategory: String) {
        super.init(nibName: nil, bundle: nil)
        self.mainCategory = mainCategory
        self.subCategory = subCategory
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint("InputSizeVC")
        initView()
    }
    
    private func initView(){
        
        title = AppStrings.sizeTitle.rawValue
        view.backgroundColor = .white
    }
    @IBAction func goToMeasureAR(_ sender: UIButton) {
    }
    @IBAction func goToCheckFit(_ sender: UIButton) {
        navigationController?.pushViewController(CheckFitVC(), animated: true)
    }
}
