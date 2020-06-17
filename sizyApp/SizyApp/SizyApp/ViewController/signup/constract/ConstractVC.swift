//
//  ConstractVC.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/11.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class ConstractVC: UIViewController {

    private var serviceConsractBtn: UIButton! = UIButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(AppStrings.constractServiceBtn.rawValue, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
    })
    private var personalConstractBtn: UIButton! = UIButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(AppStrings.constractPersonBtn.rawValue, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
    })
    private var goBackBtn: UIButton! = UIButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(AppStrings.constractGoBack.rawValue, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
    })
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        title = AppStrings.constraintTitle.rawValue
        
        self.view.addSubview(serviceConsractBtn)
        setupServiceConstractBtn()
        self.view.addSubview(personalConstractBtn)
        setupPersonalConstractBtn()
        self.view.addSubview(goBackBtn)
        setupGoBackBtn()
    }
    
    private func setupServiceConstractBtn(){
        NSLayoutConstraint.activate([
            serviceConsractBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            serviceConsractBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
            serviceConsractBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            serviceConsractBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 10),
            serviceConsractBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupPersonalConstractBtn(){
          NSLayoutConstraint.activate([
              personalConstractBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
              personalConstractBtn.topAnchor.constraint(equalTo: self.serviceConsractBtn.bottomAnchor,constant: 10),
              personalConstractBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
              personalConstractBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
              personalConstractBtn.heightAnchor.constraint(equalToConstant: 40)
          ])
      }
    
    private func setupGoBackBtn(){
        NSLayoutConstraint.activate([
            goBackBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            goBackBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            goBackBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            goBackBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            goBackBtn.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        goBackBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
}
extension ConstractVC{
    @objc private func dismissVC(sender: UIButton){
        debugPrint("dismissVC")
        navigationController?.popViewController(animated: true)
    }
}
