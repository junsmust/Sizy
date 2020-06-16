//
//  SignUpViewController.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/09.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit
import Then

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var rePwTextFd: UITextField!
    @IBOutlet weak var rePwLb: UILabel!
    @IBOutlet weak var alertPwLb: UILabel!
    @IBOutlet weak var pwTextFd: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pwLb: UILabel!
    private var email: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTexts()
        nextBtn.addTarget(self, action: #selector(moveToPwView(sender:)), for: .touchUpInside)
    }
    init(userEmail email: String) {
        super.init(nibName: nil, bundle: nil)
        self.email = email
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupTexts(){
        
        title = AppStrings.signUpTitle.rawValue
        
        rePwTextFd.placeholder = AppStrings.rePasswordLb.rawValue
        rePwLb.text = AppStrings.rePasswordLb.rawValue
        alertPwLb.text = AppStrings.pwPlaceHolder.rawValue
        pwTextFd.placeholder = AppStrings.pwPlaceHolder.rawValue
        pwLb.text = AppStrings.passwordLb.rawValue
        nextBtn.setTitle(AppStrings.nextBtn.rawValue, for: .normal)
    }
    @objc func moveToPwView(sender: UIButton){
        navigationController?.pushViewController(CompleteSignupVC(userEmail: email), animated: true)
    }
    
}
