//
//  UserInfoVC.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/10.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    @IBOutlet weak var heighhtAndWeighthDescriptionLb: UILabel!
    @IBOutlet weak var heighhtAndWeightSubDescpriotionLb: UILabel!
    @IBOutlet weak var weighthLb: UILabel!
    @IBOutlet weak var heightLb: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var weightTextFd: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTexts()
        setupTextFieldType()
        setupAction()
    }
    
    private func setupTexts(){
        
        title = AppStrings.signUpTitle.rawValue
        heighhtAndWeightSubDescpriotionLb.text = AppStrings.heighhtAndWeightDescriptionSubLb.rawValue
        
        heighhtAndWeighthDescriptionLb.numberOfLines = 2
        heighhtAndWeighthDescriptionLb.text = AppStrings.heighhtAndWeightDescriptionLb.rawValue
        
        weighthLb.text = AppStrings.weightLb.rawValue
        heightLb.text = AppStrings.heightLb.rawValue
        signUpBtn.setTitle(AppStrings.signUpTitle.rawValue, for: .normal)
    }
    private func setupTextFieldType(){
        weightTextFd.textContentType = .telephoneNumber
        heightTextField.textContentType = .telephoneNumber
    }
    private func setupAction(){
        signUpBtn.addTarget(self, action: #selector(moveToMain(sender:)), for: .touchUpInside)
    }
    @objc func moveToMain(sender:UIButton){
        navigationController?.pushViewController(MainVC(name: ""), animated: true)
    }

}
