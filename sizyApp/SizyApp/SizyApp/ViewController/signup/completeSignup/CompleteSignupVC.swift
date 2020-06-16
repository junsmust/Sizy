//
//  CompleteSignupVC.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/10.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class CompleteSignupVC: UIViewController {
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var youCanDoLaterLb: UILabel!
    @IBOutlet weak var nickNameLb: UILabel!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaieBtn: UIButton!
    @IBOutlet weak var userEmailLb: UILabel!
    @IBOutlet weak var welcomeLb: UILabel!
    private var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
        setupAction()
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
        youCanDoLaterLb.text = AppStrings.youCanDoLater.rawValue
        nickNameLb.text = AppStrings.nickNameLb.rawValue
        maleBtn.setTitle(AppStrings.maleBtn.rawValue, for: .normal)
        femaieBtn.setTitle(AppStrings.fealeBtn.rawValue, for: .normal)
        userEmailLb.text = email
        welcomeLb.text = AppStrings.Welcome.rawValue
        nextBtn.setTitle(AppStrings.nextBtn.rawValue, for: .normal)
    }
    private func setupAction(){
        nextBtn.addTarget(self, action: #selector(moveToUserInfo(sender:)), for: .touchUpInside)
    }
    @objc func moveToUserInfo(sender:UIButton){
        navigationController?.pushViewController(UserInfoVC(), animated: true)
    }
}
